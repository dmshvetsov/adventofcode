CANNOT_CONTAIN_BAGS = 'contain no other bags'.freeze

def solution(data, should_contain)
  tree = [[should_contain, 1]]
  count = 1
  until tree.empty?
    search_bag, num = tree.pop
    bag_line = data.find { |line| line.start_with?(search_bag) }
    if bag_line
      contains = bag_line
        .split(' bags contain ')
        .last
        .split(', ')
        .map { |bag| bag_color_count(bag, num) }
      tree += contains
    end
    count += num
  end
  count - 2
end

def bag_color_count(str, parent_count)
  num, kind, color, = str.split(' ')
  ["#{kind} #{color}", num.to_i * parent_count]
end

def read_input(file_path)
  File.readlines(file_path)
end

def prepare(data)
  data
    .filter { |line| !line.include?(CANNOT_CONTAIN_BAGS) }
    .map { |line| line[0..-3] }
end

puts "Example1 == 32: #{solution(prepare(read_input('example_input_1.txt')), 'shiny gold')}"
puts "Example2 == 126: #{solution(prepare(read_input('example_input_2.txt')), 'shiny gold')}"
puts "Solution: #{solution(prepare(read_input('input.txt')), 'shiny gold')}"
