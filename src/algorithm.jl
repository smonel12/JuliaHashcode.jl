using HashCode2014
using JuliaHashcode

"""
    Car
Store a car made of the car's path, duration, and if it's still running.
# Fields
- `path::Vector{Int}`: path the car has traveled
- `duration::Int`: total duration the car has traveled
- `is_running::Bool`: tells if the car is still running or reached end of duration
"""
Base.@kwdef mutable struct Car
    path::Vector{Int}
    duration::Int
    is_running::Bool
end

"""
    greedy_algo(problem)

Runs a greedy algorithm for each car to find the best paths to achieve the highest score.
"""
function greedy_algo(problem::City)
    (; total_duration, n_cars, start_point, neighboring_streets, streets, visited) = problem
    itineraries = Vector{Vector{Int}}(undef, n_cars)
    depth = 14
    paths = Vector{Car}(undef, n_cars)
    visited_streets = deepcopy(visited)
    # Creates a struct for each car
    for c = 1:n_cars
        path = Car(; path = [start_point], duration = 0, is_running = true)
        paths[c] = path
    end
    i = 1

    while true
        car = paths[i]
        # If car's duration is still is below total_duration continue
        if car.is_running
            itinerary = car.path
            duration = car.duration
            # Find the best path of length 15
            best_path, current_duration = find_best_path(
                depth,
                depth,
                duration,
                total_duration,
                streets,
                visited_streets,
                neighboring_streets,
                last(itinerary),
            )
            # Append best path to car's current path and add the new duration
            if length(best_path) > 1
                pop!(itinerary)
                append!(itinerary, best_path)
                duration = current_duration
                car.path = itinerary
                car.duration = duration
            else
                car.is_running = false
            end

        else
            # Check if all cars reached total duration to end
            one_car_running = false
            for car in paths
                if car.is_running
                    one_car_running = true
                    break
                end
            end
            if one_car_running == false
                break
            end
        end
        # Resets i if it gets through all n_cars
        if i == n_cars
            i = 1
        else
            i += 1
        end
    end
    # Add the car's paths to the itineraries
    for c = 1:n_cars
        itineraries[c] = paths[c].path
    end
    return Solution(problem, itineraries)
end

"""
    find_best_path(depth, total_depth, duration, total_duration, streets, visited, neighboring_streets, current_position)

Runs a recursive greedy algorithm to find the best path of length `total_depth` from `current_position` making sure it
doesn't exceed `duration`
"""
function find_best_path(
    depth::Int,
    total_depth::Int,
    duration::Int,
    total_duration::Int,
    streets::Vector{Street},
    visited::Dict{Street,Bool},
    neighboring_streets::Dict{Int,Vector{Street}},
    current_position::Int,
)
    best_score = -1
    best_path = [current_position]
    current_duration = duration
    # Iterate through adjacent streets
    if depth > 0
        # Gets adjacent streets of the current position
        candidates = neighboring_streets[current_position]
        for street in candidates
            if duration + street.duration <= total_duration
                score = 0
                not_visited = visited[street]
                # If the street not visited, score is added
                if not_visited == false
                    score = street.distance
                end
                visited[street] = true

                new_position = get_street_end(current_position, street)
                # Goes to the next depth
                new_score, path, new_duration = find_best_path(
                    depth - 1,
                    total_depth,
                    duration + street.duration,
                    total_duration,
                    streets,
                    visited,
                    neighboring_streets,
                    new_position,
                )

                score += new_score
                visited[street] = not_visited

                # Updates best path and duration 
                if (score > best_score)
                    best_score = score
                    current_duration = new_duration
                    best_path = path
                    pushfirst!(best_path, current_position)
                end
            end
        end
    else
        best_score = 0
    end

    # Returns best path
    if depth == total_depth
        update_visited_path(best_path, visited, streets)
        return best_path, current_duration
    end

    return best_score, best_path, current_duration
end

"""
    update_visited_path(best_path, visited, streets)

After finding the `best_path`, update `visited` to reflect the streets that has been traversed.
"""
function update_visited_path(
    best_path::Vector{Int},
    visited::Dict{Street,Bool},
    streets::Vector{Street},
)
    for i = 1:(length(best_path)-1)
        for street in streets
            if is_street(best_path[i], best_path[i+1], street)
                visited[street] = true
                break
            end
        end
    end
end
