def solution(data, preamble):
    n = invalid_number(data, preamble)
    contiguous = []
    span = 0
    idx = 0
    while idx < len(data):
        a = data[idx]
        if sum(contiguous) + a == n:
            contiguous.append(a)
            return min(contiguous) + max(contiguous)
        if sum(contiguous) + a < n:
            contiguous.append(a)
            span += 1
            idx += 1
        else:
            contiguous.pop(0)
            span -= 1

def invalid_number(data, preamble):
    sums = []
    for i, a in enumerate(data[:preamble]):
        for j, b in enumerate(data[:preamble]):
            if i == j:
                continue
            sums.append(a + b)

    for pointer, n in enumerate(data[preamble:]):
        if n not in sums:
            return n
        sums = sums[preamble:]
        sums = sums + [n + x for x in data[pointer:preamble + pointer]]

def read_input(file_path):
    with open(file_path, 'rt') as fi:
        return [prepare_input(line) for line in fi]

def prepare_input(line):
    return int(line.strip())

if __name__ == '__main__':
    print(solution(read_input('example_input'), 5))
    print(solution(read_input('input'), 25))
