require 'set'

def solution(instructions)
  dir = [
    ['e', [1, 0]],
    ['se', [0, 1]],
    ['sw', [-1, 1]],
    ['w', [-1, 0]],
    ['nw', [0, -1]],
    ['ne', [1, -1]]
  ]
  instructions.each_with_object(Set.new) do |path, flipped|
    # p "path: #{path}"
    coordinate = [0, 0]
    until path.empty?
      matched, move = dir.find { |(dir, _)| path.start_with?(dir) }
      # p path, memo unless matched
      coordinate[0] += move[0]
      coordinate[1] += move[1]
      path = path.sub(matched, '')
      # p "coord: #{coordinate}, move: #{move}, path: #{path}, matched: #{matched}"
    end
    flipped.delete(coordinate) unless flipped.add?(coordinate)
    # p "flipped: #{flipped}, instr coord #{coordinate}"
  end.size
end

def prepare_input(input)
  input.map(&:strip!)
end

def read_input(file_path)
  File.readlines(file_path)
end

puts solution(prepare_input(read_input('example_input.txt')))
puts solution(prepare_input(read_input('input.txt')))
