def solution(cups, moves)
  mod = cups.size
  current = 0

  moves.times do |m|
    dest_idx = nil
    reductor = 1

    picked_up = cups.slice!(current + 1, 3)
    current_balancer = 0
    if picked_up.size < 3
      current_balancer = 3 - picked_up.size
      picked_up += cups.slice!(0, 3 - picked_up.size)
    end
    prev_current_cup = cups[current - current_balancer]
    current_cup = current < cups.size ? cups[current] : cups[current - current_balancer]

    loop  do
      if picked_up.include?(current_cup - reductor)
        reductor += 1
      elsif cups.min > current_cup - reductor
        dest_idx = cups.index { |item| item == cups.max }
        break
      else
        dest_idx = cups.index { |item| item == current_cup - reductor }
        break
      end
    end
    cups.insert(dest_idx + 1, *picked_up)
    stop = 0
    while cups[current] != prev_current_cup
      cups.rotate!(1)
      # p cups
      stop += 1
      throw 'ops' if stop > cups.size + 1
    end
    current = (current + 1) % mod
  end
  cups.rotate!(1) until cups[0] == 1
  cups.drop(1).join('')
end

def read_input(str)
  str.split('').map(&:to_i)
end

puts solution(read_input('389125467'), 10)
puts solution(read_input('389125467'), 100)
puts solution(read_input('327465189'), 100)
