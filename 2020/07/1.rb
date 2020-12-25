require 'set'

CANNOT_CONTAIN_BAGS = 'contain no other bags'.freeze

def solution(data, should_contain)
  contains = [should_contain]
  seen = Set[should_contain]
  line_contains = Set.new
  until contains.empty?
    seach_for = contains.pop
    data.each_with_index do |line, line_num|
      next unless line.include?(seach_for)

      bag = line.split(' bags ').first
      next if bag == seach_for

      line_contains << line_num
      contains << bag if seen.add?(bag)
    end
  end
  line_contains.size
end

def read_input(file_path)
  File.readlines(file_path)
end

def sanitize_input(data)
  data.filter { |line| !line.include?(CANNOT_CONTAIN_BAGS) }
end

puts "Example: #{solution(sanitize_input(read_input('example_input_1.txt')), 'shiny gold')}"
puts "Solution: #{solution(read_input('input.txt'), 'shiny gold')}"
