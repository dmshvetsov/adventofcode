import os
import v.util { imin, imax }

const (
	empty = 'L'
	occupied = '#'
	floor = '.'
	directions = [[-1,-1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
)

fn main() {
	println(
		solution(prepare_input(read_input('./example_input')))
	)
	println(
		solution(prepare_input(read_input('./input')))
	)
}

fn solution(data [][]string) int {
	pp(data)
	mut cur := data
	mut initial_occupied := 0
	for true {
		changed := run_round(cur)
		now_occupied := count_occupied(changed)
		if now_occupied == initial_occupied {
			break
		}
		initial_occupied = now_occupied
		cur = changed
	}
	return initial_occupied
}

fn run_round(initial [][]string) [][]string {
	mut changed := [][]string{len: initial.len, init: []string{len: initial[0].len}}
	for i, line in initial {
		for j, space in line {
			if space == empty && num_adjacent_occupied(i, j, initial) == 0 {
				changed[i][j] = occupied
			} else if space == occupied && num_adjacent_occupied(i, j, initial) > 4 {
				changed[i][j] = empty
			} else {
				changed[i][j] = initial[i][j]
			}
		}
	}
	return changed
}

fn num_adjacent_occupied(x int, y int, data [][]string) int {
	mut count := 0
	for direction in directions {
		mut i := x + direction[0]
		mut j := y + direction[1]
		for 0 <= i && i < data.len && 0 <= j && j < data[i].len {
			if data[i][j] != floor {
				if data[i][j] == occupied {
					count++
				}
				break
			}
			i = i + direction[0]
			j = j + direction[1]
		}
	}
	return count
}

fn count_occupied(data [][]string) int {
	mut count := 0
	for line in data {
		for space in line {
			if space == occupied {
				count++
			}
		}
	}
	return count
}

/**
 * Utility functions
 */

fn prepare_input(lines []string) [][]string {
  mut splitted := [][]string{}
  for line in lines {
    splitted << line.split('')
  }
  return splitted
}

fn read_input(file_path string) []string {
  content := os.read_lines(file_path) or {
    return []string{}
  }
  return content
}

fn pp(data [][]string) {
	for line in data {
		println(line.join(''))
	}
}
