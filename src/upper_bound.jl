using JuliaHashcode

"""
    prove_upper_bound()

Proves upper bound is valid for the problem.
"""
function prove_upper_bound()
    city = read_problem()
    n_cars = city.n_cars
    distance, duration = calculate_totals(city)
    return duration < city.total_duration * n_cars
end

"""
    calculate_totals(city)

Calculate total street distance and street durations for the entire city.
"""
function calculate_totals(city::City)
    total = 0
    duration = 0
    for street in city.streets
        total += street.distance
        duration += street.duration
    end
    return total, duration
end
