using Base.Iterators

# https://adventofcode.com/2022/day/3

input = readlines("2022/data/day_3.txt")

compartments(line) = compartments(collect(line))
compartments(chars::Vector{Char}) = chars[1:div(end,2)], chars[div(end,2) + 1:end]

priority(item::Char) = isuppercase(item) ? item - 'A' + 27 : item - 'a' + 1

test1 = """vJrwpWtwJgWrhcsFMMfFFhFp
           jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
           PmmdzqPrVvPwwTWBwg
           wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
           ttgJtRGJQctTZtZT
           CrZsJsPPZsGzwwsLwLmpwMDw"""

part_1(split(test1))

function part_1(input)
    return sum(input) do line
        c1, c2 = compartments(line)
        common = only(intersect(c1, c2))
        return priority(common)
    end
end
@info part_1(input)

function part_2(input)
    sum(partition(input, 3)) do squad
        badge = mapreduce(Set ∘ collect, intersect, squad)
        return priority(only(badge))
    end
end
@info part_2(input)
