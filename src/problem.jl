using HashCode2014
using Graphs

"""
    City
Store a city made of [`Junction`](@ref)s and [`Street`](@ref)s, along with additional instance parameters.
# Fields
- `total_duration::Int`: total time allotted for the car itineraries (in seconds)
- `n_cars::Int`: number of cars in the fleet
- `start_point::Int`: junction at which all the cars are located initially
- `neighboring_streets::Dict{Int, Vector{Street}}`: dictionary mapping street junctions to connecting streets
- `streets::Vector{Street}`: list of streets
- `visited::Dict{Street, Bool}`: dictionary mapping street to boolean value
"""

Base.@kwdef struct City
    total_duration::Int
    n_cars::Int
    start_point::Int
    neighboring_streets::Dict{Int,Vector{Street}}
    streets::Vector{Street}
    visited::Dict{Street,Bool}
end

function City(data::AbstractString)
    lines = split(data, "\n")
    N, M, T, C, S = map(s -> parse(Int, s), split(lines[1]))

    streets = Vector{Street}(undef, M)
    for j in 1:M
        Aⱼ, Bⱼ, Dⱼ, Cⱼ, Lⱼ = map(s -> parse(Int, s), split(lines[1 + N + j]))
        streets[j] = Street(;
            endpointA=Aⱼ + 1,
            endpointB=Bⱼ + 1,
            bidirectional=Dⱼ == 2,
            duration=Cⱼ,
            distance=Lⱼ,
        )
    end

    g = SimpleDiGraph()
    neighbors = Dict{Int,Vector{Street}}()
    visited = Dict{Street,Bool}()
    for start in streets
        if haskey(neighbors, start.endpointA) == false
            candidates = [
                street for (s, street) in enumerate(streets) if
                (is_street_start(start.endpointA, street))
            ]
            neighbors[start.endpointA] = candidates
        end
        if haskey(neighbors, start.endpointB) == false
            candidates = [
                street for (s, street) in enumerate(streets) if
                (is_street_start(start.endpointB, street))
            ]
            neighbors[start.endpointB] = candidates
        end
        visited[start] = false
    end

    city = City(;
        total_duration=T,
        n_cars=C,
        start_point=S + 1,
        neighboring_streets=neighbors,
        streets=streets,
        visited=visited,
    )
    return city
end

function Base.string(city::City)
    M = length(city.streets)
    T, C, S = city.total_duration, city.n_cars, city.start_point - 1
    s = "$M $T $C $S\n"
    for street in city.streets
        s *= string(street) * "\n"
    end
    return chop(s; tail=1)
end

"""
    read_problem(path)

Read and parse a [`City`](@ref) from a file located at `path`.

The default path is an artifact containing the official challenge data.
"""
function read_problem(
    path=joinpath(artifact"HashCode2014Data", "HashCode2014Data-0.1", "paris_54000.txt")
)
    city_string = open(path, "r") do file
        read(file, String)
    end
    return City(city_string)
end

"""
    write_city(city, path)
Write a [`City`](@ref) to a file located at `path`.
"""
function write_city(city::City, path)
    city_string = string(city)
    open(path, "w") do file
        write(file, city_string)
    end
end