"""
    Solution

Store a set of itineraries, one for each car.

# Fields
- `city::City`: 
- `itineraries::Vector{Vector{Int}}`: each itinerary is a vector of junction indices
- `feasible::Bool`: tells if the solution is feasible given the city
- `total::Int`: total is the total distance the cars travel in the solution
"""
Base.@kwdef struct Solution
    city::City
    itineraries::Vector{Vector{Int}}
    feasible::Bool
    total::Int
end

function Solution(city::City, itineraries::Vector{Vector{Int}})
    feasible = is_feasible(itineraries, city)
    total = total_distance(itineraries, city)
    return Solution(; city=city, itineraries=itineraries, feasible=feasible, total=total)
end

function Base.string(solution::Solution)
    C = length(solution.itineraries)
    s = "$C\n"
    for itinerary in solution.itineraries
        V = length(itinerary)
        s *= "$V\n"
        for i in itinerary
            s *= "$(i-1)\n"
        end
    end
    return chop(s; tail=1)
end

"""
read_solution(solution, path)
Read and parse a [`Solution`](@ref) from a file located at `path`.
"""
function read_solutions(city::City, path)
    solution_string = open(path, "r") do file
        read(file, String)
    end
    lines = split(solution_string, "\n")
    cars = parse(Int, lines[1])
    itineraries = Vector{Vector{Int}}(undef, cars)
    k = 2
    for car in 1:cars
        junctions_visited = parse(Int, lines[k])
        itinerary = Vector{Int}(undef, junctions_visited)
        for v in 1:junctions_visited
            i = parse(Int, lines[k + v])
            itinerary[v] = i + 1
        end
        itineraries[car] = itinerary
        k += junctions_visited + 1
    end
    return Solution(city, itineraries)
end

"""
write_solution(solution, path)
Write a [`Solution`](@ref) to a file located at `path`.
"""
function write_solutions(solution::Solution, path)
    solution_string = string(solution)
    open(path, "w") do file
        write(file, solution_string)
    end
end
