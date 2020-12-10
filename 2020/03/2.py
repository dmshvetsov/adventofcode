from collections import namedtuple
from functools import reduce

Slope = namedtuple('Slope', 'right down')

TREE = '#'
OPEN = '.'

def solution(data, slopes):
    return reduce((lambda a, b: a * b), [count_trees_on_slope(data, slope) for slope in slopes])

def count_trees_on_slope(data, slope):
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
    slopes = [Slope(*args) for args in [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]]
    print(solution(read_input('example_input'), slopes))
    print(solution(read_input('input'), slopes))
