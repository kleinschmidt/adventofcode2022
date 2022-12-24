# https://adventofcode.com/2022/day/2

input = readlines("2022/data/day_2.txt")

# A, B, C => rock/paper/scissors
# X, Y, Z => rock/paper/scissors
#
# 1, 2, 3 point for r/p/s
# 0, 3, 6 for win/lose/draw

@enum Play rock=1 paper=2 scissors=3

function score(other::Play, self::Play)
    diff = mod(Int(self) - Int(other), 3)
    # 0 diff is tie, +1 is win, -1/+2 is lose
    score = Int(self)
    if diff == 1
        score += 6
    elseif diff == 0
        score += 3
    end
    return score
end

moves = Dict("A" => rock,
             "B" => paper,
             "C" => scissors,
             "X" => rock,
             "Y" => paper,
             "Z" => scissors)

score(other, self) = score(moves[other], moves[self])
score(line::Vector) = score(line...; lookup)

part1_test = """A Y
                B X
                C Z"""
part1_test_lines = split(part1_test, '\n')
score.(split.(part1_test_lines))

function part_1(input)
    sum(score, split.(input))
end
@info part_1(input)

function decode(other, outcome)
    # X lose, Y draw, Z win
    # winning move is +1, losing is -1...
    diff = only(outcome) - 'Y'
    other = moves[other]
    self = Play(mod1(Int(other) + diff, 3))
    return other, self
end

function part_2(input)
    sum(score(decode(line...)...) for line in split.(input))
end
@info part_2(input)
