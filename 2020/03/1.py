from collections import namedtuple

Slope = namedtuple('Slope', 'right down')

TREE = '#'
OPEN = '.'

def solution(data, slope):
    trees_on_path = 0
    xcord = 0
    ycord = 0
    while ycord < len(data):
        if data[ycord][xcord] == TREE:
            trees_on_path += 1
        xcord = (xcord + slope.right) % len(data[ycord])
        ycord += slope.down
    return trees_on_path

# Utility functions

def read_input(file_path):
    with open(file_path, 'rt') as fi:
        return fi.read().strip().split('\n')

if __name__ == '__main__':
    print(solution(read_input('example_input'), Slope(right=3, down=1)))
    print(solution(read_input('input'), Slope(right=3, down=1)))
