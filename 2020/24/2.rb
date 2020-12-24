require 'set'

DIR = {
  'e' => [1, 0],
  'se' => [0, 1],
  'sw' => [-1, 1],
  'w' => [-1, 0],
  'nw' => [0, -1],
  'ne' => [1, -1]
}.freeze

def solution(instructions, days)
  bt = laydown_black_tiles(instructions)
  days.times do
    print '.'
    bt = simulate_day(bt)
  end
  bt.size
end

def laydown_black_tiles(instructions)
  instructions.each_with_object(Set.new) do |path, flipped|
    coordinate = [0, 0]
    until path.empty?
      matched, move = DIR.find { |(dir, _)| path.start_with?(dir) }
      coordinate[0] += move[0]
      coordinate[1] += move[1]
      path = path.sub(matched, '')
    end
    flipped.delete(coordinate) unless flipped.add?(coordinate)
  end
end

def simulate_day(black_tiles)
  black_tiles.each_with_object(Hash.new(0)) do |cur_tile, neighbors|
    x, y = cur_tile
    DIR.values.each { |(dx, dy)| neighbors[[x + dx, y + dy]] += 1 }
    neighbors
  end.each_with_object(Set.new) do |(neighbor_tile, neighbor_num), new_tiles|
    if black_tiles.include?(neighbor_tile)
      new_tiles << neighbor_tile unless neighbor_num.zero? || neighbor_num > 2
    elsif neighbor_num == 2
      new_tiles << neighbor_tile
    end
  end
end

def flip_to_black_adj(a, b, tiles)
  ax, ay = a
  bx, by = b
  if ax == bx
    tiles.add([ax + 1, [ay, by].min])
    tiles.add([ax - 1, [ay, by].max])
  elsif ax != bx && ay == by
    tiles.add([[ax, bx].max, ay - 1])
    tiles.add([[ax, bx].min, ay + 1])
  elsif ax != bx && ay != by
    tiles.add([[ax, bx].min, [ay, by].min])
    tiles.add([[ax, bx].max, [ay, by].max])
  else
    throw 'woops'
  end
end

def prepare_input(input)
  input.map(&:strip!)
end

def read_input(file_path)
  File.readlines(file_path)
end

puts solution(prepare_input(read_input('example_input.txt')), 100)
puts solution(prepare_input(read_input('input.txt')), 100)
