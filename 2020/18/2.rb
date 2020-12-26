# inspired by https://en.wikipedia.org/wiki/Operator-precedence_parser#Alternative_methods

class WeirdPreceder
  REPLACERS = [
    ['(', '((('],
    [')', ')))'],
    ['+', ')+('],
    ['*', '))*(('],
  ].freeze

  def self.from(str)
    prepare = REPLACERS.reduce(str) { |acc, (pat, rep)| acc.gsub(pat, rep) }
    new("(((#{prepare})))")
  end

  def initialize(eq)
    @eq = eq
  end

  def calculate
    eval @eq
  end
end

def test(data)
  data.each do |line|
    puts WeirdPreceder.from(line).calculate
  end
end

def solution(data)
  puts(data.sum { |line| WeirdPreceder.from(line).calculate })
end

def prepare_input(input)
  input.map { |line| line.gsub(/\s/, '') }
end

def read_input(file_path)
  File.readlines(file_path)
end

puts 'Examples:'
test(prepare_input(read_input('example_input_part2.txt')))
puts "\nPuzzle:"
solution(prepare_input(read_input('input.txt')))
