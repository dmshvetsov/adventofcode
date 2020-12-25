MASK = :mask
FLOATING = 'X'.freeze

def solution(data)
  mem = Hash.new(0)
  cur_mask = nil
  data.each do |(cmd_or_adr, val)|
    if cmd_or_adr == MASK
      cur_mask = val
    else
      mem_adrs(cmd_or_adr, cur_mask).each do |adr|
        mem[adr] = val
      end
    end
  end
  mem.values.sum
end

def mem_adrs(bits, cur_mask)
  cur_mask.each_char.each_with_index do |mbit, idx|
    bits[idx] = '1' if mbit == '1'
  end

  adrs = [bits]
  cur_mask.each_char.each_with_index do |mbit, idx|
    next unless mbit == FLOATING

    adrs = adrs.reduce([]) do |acc, adr|
      a1 = adr.clone
      a1[idx] = '0'
      acc << a1
      a2 = adr.clone
      a2[idx] = '1'
      acc << a2
    end
  end
  adrs
end

def read_input(file_path)
  File.readlines(file_path)
end

def prepare(data)
  data
    .map { |line| line.strip.split(' = ') }
    .map do |(cmd, val)|
      if cmd == 'mask'
        [MASK, val]
      else
        ['%036b' % cmd[/\d+/], val.to_i]
      end
    end
end

puts "Example: #{solution(prepare(read_input('example_input_part2.txt')))}"
puts "Puzzle: #{solution(prepare(read_input('input.txt')))}"
