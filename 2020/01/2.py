# https://adventofcode.com/2020/day/1#part2

def solution_bruteforce(data, result=2020):
    for left in data:
        for right in data:
            if left + right > 2020:
                continue
            rem = result - left - right
            if rem in data:
                return rem * left * right
    return None

def solution(data, result=2020):
    data.sort()

    for bidx, base in enumerate(data):
        rem = 2020 - base
        lidx = bidx + 1
        ridx = len(data) - 1
        while (lidx < ridx):
            if data[lidx] + data[ridx] == rem:
                return base * data[lidx] * data[ridx]
            if data[lidx] + data[ridx] > rem:
                ridx -= 1
            else:
                lidx += 1

with open("input", "rt") as fi:
    data = [int(line.strip()) for line in fi]
    example_data = [1721, 979, 366, 299, 675, 1456]
    print("example", solution_bruteforce(example_data))
    print("bruteforce", solution_bruteforce(data))
    print("solution", solution(data))

