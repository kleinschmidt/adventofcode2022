# https://adventofcode.com/2022/day/4

input = readlines("2022/data/day_4.txt")

function parse_input(line)
    a, b, c, d = parse.(Int, split(line, r"[-,]"))
    return a:b, c:d
end

issymsubset(a, b) = issubset(a, b) || issubset(b, a)
issymsubset(ab) = issymsubset(ab...)

function part_1(input)
    count(issymsubset, parse_input.(input))
end
@info part_1(input)

function part_2(input)
    count(parse_input.(input)) do (a, b)
        !isempty(intersect(a, b))
    end
end
@info part_2(input)
