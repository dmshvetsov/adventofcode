def solution(depart, schedule)
  bus = schedule.min { |a, b| next_departure(depart, a) <=>  next_departure(depart, b) }
  diff = next_departure(depart, bus) - depart
  bus * diff
end

def next_departure(depart, bus)
  ((depart / bus) + 1) * bus
end

def read_input(file_path)
  File.readlines(file_path)
end

def prepare(data)
  depart, schedule = data
  [depart.strip.to_i, schedule.strip.split(',').filter { |item| item != 'x' }.map(&:to_i)]
end

puts "Example: #{solution(939, [7, 13, 59, 31, 19])}"
puts "Solution: #{solution(*prepare(read_input('input.txt')))}"
