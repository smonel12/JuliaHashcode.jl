
"""
    is_feasible(solution, city[; verbose=false])

Check if `solution` satisfies the constraints for the instance defined by `city`.
The following criteria are considered (taken from the problem statement):
- the number of itineraries has to match the number of cars of `city`
- the first junction of each itinerary has to be the starting junction of `city`
- for each consecutive pair of junctions on an itinerary, a street connecting these junctions has to exist in `city` (if the street is one directional, it has to be traversed in the correct direction)
- the duration of each itinerary has to be lower or equal to the total duration of `city`

From HashCode2014
"""
function is_feasible(itineraries::Vector{Vector{Int}}, city::City; verbose = false)
    n_cars = length(itineraries)
    if n_cars != city.n_cars
        verbose && @warn "Incoherent number of cars"
        return false
    else
        for (c, itinerary) in enumerate(itineraries)
            if first(itinerary) != city.start_point
                verbose && @warn "Itinerary $c has invalid starting junction"
                return false
            else
                duration = 0
                for v = 1:(length(itinerary)-1)
                    i, j = itinerary[v], itinerary[v+1]
                    exists = false
                    for street in city.streets
                        if is_street(i, j, street)
                            exists = true
                            duration += street.duration
                            break
                        end
                    end
                    if !exists
                        verbose && @warn "Street $i -> $j does not exist"
                        return false
                    end
                end
                if duration > city.total_duration
                    verbose &&
                        @warn "Itinerary $c has duration $duration > $(city.total_duration)"
                    return false
                end
            end
        end
    end
    return true
end

"""
    total_distance(solution, city)

Compute the total distance of all itineraries in `solution` based on the street data from `city`.
Streets visited several times are only counted once.

From HashCode2014
"""
function total_distance(itineraries::Vector{Vector{Int}}, city::City)
    L = 0
    for street in city.streets
        visited = false
        for itinerary in itineraries
            for v = 1:(length(itinerary)-1)
                i, j = itinerary[v], itinerary[v+1]
                if is_street(i, j, street)
                    L += street.distance
                    visited = true
                    break
                end
            end
            if visited
                break
            end
        end
    end
    return L
end

"""
    is_street_start(i, street)

Check if junction `i` corresponds to a valid starting point of `street`.

From HashCode2014
"""
function is_street_start(i::Integer, street::Street)
    if i == street.endpointA
        return true
    elseif street.bidirectional && i == street.endpointB
        return true
    else
        return false
    end
end

"""
    is_street(i, j, street)

Check if the trip from junction `i` to junction `j` corresponds to a valid direction of `street`.

From HashCode2014
"""
function is_street(i::Integer, j::Integer, street::Street)
    if (i, j) == (street.endpointA, street.endpointB)
        return true
    elseif (street.bidirectional && (i, j) == (street.endpointB, street.endpointA))
        return true
    else
        return false
    end
end

"""
    get_street_end(i, street)

Retrieve the arrival endpoint of `street` when it starts at junction `i`.

From HashCode2014
"""
function get_street_end(i::Integer, street::Street)
    if i == street.endpointA
        return street.endpointB
    elseif street.bidirectional && i == street.endpointB
        return street.endpointA
    else
        return 0
    end
end
