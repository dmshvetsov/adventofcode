# inspired by https://github.com/lizthegrey/adventofcode/blob/main/2020/day13.go
# and https://github.com/PaulJuliusMartinez/advent-of-code/blob/master/2020/dec13.rb

def solution(schedule)
  min_val = 0
  runnung_product = 1
  schedule.each_with_index do |bus_num, idx|
    next if bus_num.zero?

    min_val += runnung_product while (min_val + idx) % bus_num != 0
    runnung_product *= bus_num
  end
  min_val
end

# draw_table = Enumerator.new do |enum|
#   step = 0
#   loop do
#     schedule = [17, 0, 13, 19]
#     deps = schedule.map { |t| !t.zero? && step % t == 0 ? 'D' : '.' }.join(' ')
#     enum.yield "#{'%-5.5s' % (step).to_s}#{deps}\n"
#     step += 1
#   end
# end
# 80.times { puts draw_table.next }

def read_input(file_path)
  File.readlines(file_path)
end

def prepare(data)
  _, schedule = data
  schedule.strip.split(',').map(&:to_i)
end

puts "Example == 3417: #{solution([17, 0, 13, 19])}"
puts "Example == 1202161486: #{solution([1789, 37, 47, 1889])}"
puts "Solution: #{solution(prepare(read_input('input.txt')))}"
