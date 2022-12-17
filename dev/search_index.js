var documenterSearchIndex = {"docs":
[{"location":"upper_bound/#Proving-upper-bound","page":"Upper Bound Proof","title":"Proving upper bound","text":"","category":"section"},{"location":"upper_bound/","page":"Upper Bound Proof","title":"Upper Bound Proof","text":"The upper bound of the street view routing problem is based on if the total duration of all the streets is lower than the max duration multiplied by the total cars. As stated by the problem, the duration for each car is 54000 and the amount of cars is 8. Therefore the total duration over all the cars is 432000. Given the total duration taken from the city streets is less than 432000. The 8 cars should be able to traverse all the given streets in the time limit.","category":"page"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = JuliaHashcode","category":"page"},{"location":"#JuliaHashcode","page":"Home","title":"JuliaHashcode","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for JuliaHashcode.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [JuliaHashcode]","category":"page"},{"location":"#JuliaHashcode.Car","page":"Home","title":"JuliaHashcode.Car","text":"Car\n\nStore a car made of the car's path, duration, and if it's still running.\n\nFields\n\npath::Vector{Int}: path the car has traveled\nduration::Int: total duration the car has traveled\nis_running::Bool: tells if the car is still running or reached end of duration\n\n\n\n\n\n","category":"type"},{"location":"#JuliaHashcode.Solution","page":"Home","title":"JuliaHashcode.Solution","text":"Solution\n\nStore a set of itineraries, one for each car.\n\nFields\n\ncity::City: Set of parameters from problem\nitineraries::Vector{Vector{Int}}: each itinerary is a vector of junction indices\nfeasible::Bool: tells if the solution is feasible given the city\ntotal::Int: total is the total distance the cars travel in the solution\n\n\n\n\n\n","category":"type"},{"location":"#JuliaHashcode.calculate_totals-Tuple{City}","page":"Home","title":"JuliaHashcode.calculate_totals","text":"calculate_totals(city)\n\nCalculate total street distance and street durations for the entire city.\n\n\n\n\n\n","category":"method"},{"location":"#JuliaHashcode.find_best_path-Tuple{Int64, Int64, Int64, Int64, Vector{HashCode2014.Street}, Dict{HashCode2014.Street, Bool}, Dict{Int64, Vector{HashCode2014.Street}}, Int64}","page":"Home","title":"JuliaHashcode.find_best_path","text":"find_best_path(depth, total_depth, duration, total_duration, streets, visited, neighboring_streets, current_position)\n\nRuns a recursive greedy algorithm to find the best path of length total_depth from current_position making sure it doesn't exceed duration\n\n\n\n\n\n","category":"method"},{"location":"#JuliaHashcode.get_street_end-Tuple{Integer, HashCode2014.Street}","page":"Home","title":"JuliaHashcode.get_street_end","text":"get_street_end(i, street)\n\nRetrieve the arrival endpoint of street when it starts at junction i.\n\nFrom HashCode2014\n\n\n\n\n\n","category":"method"},{"location":"#JuliaHashcode.greedy_algo-Tuple{City}","page":"Home","title":"JuliaHashcode.greedy_algo","text":"greedy_algo(problem)\n\nRuns a greedy algorithm for each car to find the best paths to achieve the highest score.\n\n\n\n\n\n","category":"method"},{"location":"#JuliaHashcode.is_feasible-Tuple{Vector{Vector{Int64}}, City}","page":"Home","title":"JuliaHashcode.is_feasible","text":"is_feasible(solution, city[; verbose=false])\n\nCheck if solution satisfies the constraints for the instance defined by city. The following criteria are considered (taken from the problem statement):\n\nthe number of itineraries has to match the number of cars of city\nthe first junction of each itinerary has to be the starting junction of city\nfor each consecutive pair of junctions on an itinerary, a street connecting these junctions has to exist in city (if the street is one directional, it has to be traversed in the correct direction)\nthe duration of each itinerary has to be lower or equal to the total duration of city\n\nFrom HashCode2014\n\n\n\n\n\n","category":"method"},{"location":"#JuliaHashcode.is_street-Tuple{Integer, Integer, HashCode2014.Street}","page":"Home","title":"JuliaHashcode.is_street","text":"is_street(i, j, street)\n\nCheck if the trip from junction i to junction j corresponds to a valid direction of street.\n\nFrom HashCode2014\n\n\n\n\n\n","category":"method"},{"location":"#JuliaHashcode.is_street_start-Tuple{Integer, HashCode2014.Street}","page":"Home","title":"JuliaHashcode.is_street_start","text":"is_street_start(i, street)\n\nCheck if junction i corresponds to a valid starting point of street.\n\nFrom HashCode2014\n\n\n\n\n\n","category":"method"},{"location":"#JuliaHashcode.prove_upper_bound-Tuple{}","page":"Home","title":"JuliaHashcode.prove_upper_bound","text":"prove_upper_bound()\n\nProves upper bound is valid for the problem.\n\n\n\n\n\n","category":"method"},{"location":"#JuliaHashcode.read_problem","page":"Home","title":"JuliaHashcode.read_problem","text":"read_problem(path)\n\nRead and parse a City from a file located at path.\n\nThe default path is an artifact containing the official challenge data.\n\nFrom HashCode2014\n\n\n\n\n\n","category":"function"},{"location":"#JuliaHashcode.read_solutions-Tuple{City, Any}","page":"Home","title":"JuliaHashcode.read_solutions","text":"read_solution(solution, path)\n\nRead and parse a Solution from a file located at path.\n\nFrom HashCode2014\n\n\n\n\n\n","category":"method"},{"location":"#JuliaHashcode.total_distance-Tuple{Vector{Vector{Int64}}, City}","page":"Home","title":"JuliaHashcode.total_distance","text":"total_distance(solution, city)\n\nCompute the total distance of all itineraries in solution based on the street data from city. Streets visited several times are only counted once.\n\nFrom HashCode2014\n\n\n\n\n\n","category":"method"},{"location":"#JuliaHashcode.update_visited_path-Tuple{Vector{Int64}, Dict{HashCode2014.Street, Bool}, Vector{HashCode2014.Street}}","page":"Home","title":"JuliaHashcode.update_visited_path","text":"update_visited_path(best_path, visited, streets)\n\nAfter finding the best_path, update visited to reflect the streets that has been traversed.\n\n\n\n\n\n","category":"method"},{"location":"#JuliaHashcode.write_city-Tuple{City, Any}","page":"Home","title":"JuliaHashcode.write_city","text":"write_city(city, path)\n\nWrite a City to a file located at path.\n\nFrom HashCode2014\n\n\n\n\n\n","category":"method"},{"location":"#JuliaHashcode.write_solutions-Tuple{Solution, Any}","page":"Home","title":"JuliaHashcode.write_solutions","text":"write_solution(solution, path)\n\nWrite a Solution to a file located at path.\n\nFrom HashCode2014\n\n\n\n\n\n","category":"method"}]
}