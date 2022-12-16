using HashCode2014
using JuliaHashcode

Base.@kwdef mutable struct Car
    path::Vector{Int}
    duration::Int
    is_running::Bool
end

function greedy_algo(problem::City)
    (; total_duration, n_cars, start_point, neighboring_streets, streets, visited) = problem
    itineraries = Vector{Vector{Int}}(undef, n_cars)
    depth = 15
    paths = Vector{Car}(undef, n_cars)
    visited_streets = deepcopy(visited)
    for c in 1:n_cars
        path = Car(; path=[start_point], duration=0, is_running=true)
        paths[c] = path
    end
    i = 1
    while true
        car = paths[i]
        if car.is_running
            itinerary = car.path
            duration = car.duration
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
        if i == 8
            i = 1
        else
            i += 1
        end
    end
    for c in 1:n_cars
        itineraries[c] = paths[c].path
    end
    return Solution(problem, itineraries)
end

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
        for i in 1:(length(best_path) - 1)
            for street in streets
                if is_street(best_path[i], best_path[i + 1], street)
                    visited[street] = true
                    break
                end
            end
        end
        return best_path, current_duration
    end

    return best_score, best_path, current_duration
end
