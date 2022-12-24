# https://adventofcode.com/2022/day/5

input = readchomp("2022/data/day_5.txt")

# "[V]         [T]         [J]        "
# "[Q]         [M] [P]     [Q]     [J]"
# "[W] [B]     [N] [Q]     [C]     [T]"
# "[M] [C]     [F] [N]     [G] [W] [G]"
# "[B] [W] [J] [H] [L]     [R] [B] [C]"
# "[N] [R] [R] [W] [W] [W] [D] [N] [F]"
# "[Z] [Z] [Q] [S] [F] [P] [B] [Q] [L]"
# "[C] [H] [F] [Z] [G] [L] [V] [Z] [H]"
# " 1   2   3   4   5   6   7   8   9 "


function parse_input(input)
    init, steps = split(input, "\n\n")

    init_lines = split(init, '\n')
    init = mapreduce(hcat, init_lines[1:end-1]) do line
        collect(line)[2:4:end]
    end
    stacks = filter.(!=(' '), collect(eachrow(init)))
    reverse!.(stacks)

    steps = map(split(steps, '\n')) do step
        m = match(r"move ([0-9]+) from (\d) to (\d)", step)
        n, from, to = parse.(Int, m.captures)
        return (; n, from, to)
    end

    return stacks, steps
end

function move!(stacks, step)
    for _ in 1:step.n
        push!(stacks[step.to], pop!(stacks[step.from]))
    end
    return stacks
end

test_input = """    [D]    
                [N] [C]    
                [Z] [M] [P]
                 1   2   3 
                
                move 1 from 2 to 1
                move 3 from 1 to 3
                move 2 from 2 to 1
                move 1 from 1 to 2"""

function part_1(input)
    stacks, steps = parse_input(input)
    for step in steps
        move!(stacks, step)
    end
    return join(last.(stacks))
end
@info part_1(input)

function move9001!(stacks, step)
    from = stacks[step.from]
    cargo = @view from[(end - step.n + 1):end]
    append!(stacks[step.to], cargo)
    resize!(from, length(from) - step.n)
    return stacks
end

function part_2(input)
    stacks, steps = parse_input(input)
    for step in steps
        move9001!(stacks, step)
    end
    return join(last.(stacks))
end
@info part_2(input)
