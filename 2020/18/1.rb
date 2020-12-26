class MathContext
  def self.from(str)
    new(str.split(''))
  end

  def initialize(seq)
    @seq = seq
    @cur_op = :add
    @acc = 0
  end

  def calculate
    left_seq = @seq
    until left_seq.empty?
      ch = left_seq.shift
      case ch
      when '*'
        @cur_op = :mult
      when '+'
        @cur_op = :add
      when '('
        sub_acc, left_seq = MathContext.new(left_seq).calculate
        @acc = if @cur_op == :mult
                 @acc * sub_acc
               else
                 @acc + sub_acc
               end
      when ')'
        return @acc, left_seq
      else
        # a number
        @acc = if @cur_op == :mult
                 @acc * ch.to_i
               else
                 @acc + ch.to_i
               end
      end
    end
    @acc
  end
end

def test(data)
  data.each do |line|
    puts MathContext.from(line).calculate
  end
end

def solution(data)
  puts(data.sum { |line| MathContext.from(line).calculate })
end

def prepare_input(input)
  input.map { |line| line.gsub(/\s/, '') }
end

def read_input(file_path)
  File.readlines(file_path)
end

puts 'Examples:'
test(prepare_input(read_input('example_input_part1.txt')))
puts "\nPuzzle:"
solution(prepare_input(read_input('input.txt')))
