def solution_bruteforce(data, preamble=25):
    for pointer, n in enumerate(data[preamble:]):
        parts = find_parts(n, data[pointer:preamble + pointer])
        if not parts:
            return n

def find_parts(n, data):
    for i, a in enumerate(data):
        for j, b in enumerate(data):
            if i == j:
                continue
            if n == a + b:
                return (a, b)
    return None

def read_input(file_path):
    with open(file_path, 'rt') as fi:
        return [prepare_input(line) for line in fi]

def prepare_input(line):
    return int(line.strip())

if __name__ == '__main__':
    print(solution_bruteforce(read_input('example_input'), 5))
    print(solution_bruteforce(read_input('input'), 25))
