using JuliaHashcode

function find_upper_bound()
    city = read_problem()
    n_cars = city.n_cars
    distance, duration = calculate_totals(city)
    distance_per_car = distance / n_cars
    duration_per_car = duration / n_cars
    return distance_per_car < city.total_duration
end

function calculate_totals(city::City)
    total = 0
    duration = 0
    for street in city.streets
        total += street.distance
        duration += street.duration
    end
    return total, duration
end

function calculate_shortest_path(city::City)
    return starting = city.start_point
end
