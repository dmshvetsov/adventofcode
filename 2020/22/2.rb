require 'set'

def combat(hands)
  played = Set.new

  until hands[0].empty? || hands[1].empty?
    return 0 if played.include?(hands)

    played << hands.map(&:dup)

    head = hands.map(&:shift)
    round_winner = if hands.zip(head).all? { |hand_tail, card| hand_tail.size >= card}
                     combat(hands.map.with_index { |hand_tail, idx| hand_tail[0, head[idx]] })
                   else
                     head[0] > head[1] ? 0 : 1
                   end

    if round_winner.zero?
      hands[0] += head
    else
      hands[1] += head.reverse
    end
  end

  1 - hands.find_index(&:empty?)
end

def calculte_score(cards)
  cards.reverse.each_with_index.reduce(0) { |score, (card, idx)| score + card * (idx + 1) }
end

def solution(hands)
  winner = combat(hands)
  calculte_score(hands[winner])
end

def prepare_input(input)
  input.each_with_object([]) do |line, hands|
    case line
    when /Player/
      hands << []
    when /\d+/
      hands.last << line.strip.to_i
    end
  end
end

def read_input(file_path)
  File.readlines(file_path)
end

p solution(prepare_input(read_input('example_input')))
p solution([[43, 19], [2, 29, 14]])
p solution(prepare_input(read_input('input')))
