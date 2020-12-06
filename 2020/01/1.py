# https://adventofcode.com/2020/day/1

def solution_bruteforce(data, result=2020):
    for i, left in enumerate(data):
        for j, right in enumerate(data):
            if i == j:
                continue
            if left + right == result:
                return left * right
    return None

def solution(data, result=2020):
    data.sort()
    lidx = 0
    ridx = len(data) - 1
    while (lidx < ridx):
        if data[lidx] + data[ridx] == result:
            return data[lidx] * data[ridx]
        if data[lidx] + data[ridx] > result:
            ridx -= 1
        else:
            lidx += 1


with open("input", "rt") as fi:
    data = [int(line.strip()) for line in fi]
    print(solution_bruteforce(data.copy()))
    print(solution(data.copy()))
