# https://adventofcode.com/2022/day/1
using AdventOfCode

input = readchomp("2022/data/day_1.txt")

function part_1(input)
    elves = split.(split(input, "\n\n"), '\n')
    calories = [sum(parse.(Int, snacks)) for snacks in elves]
    return maximum(calories)
end
@info part_1(input)

function part_2(input)
    elves = split.(split(input, "\n\n"), '\n')
    calories = [sum(parse.(Int, snacks)) for snacks in elves]
    top3 = partialsortperm(calories, 1:3; rev=true)
    return sum(calories[top3])
end
@info part_2(input)
