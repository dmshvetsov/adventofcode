def solution(hands)
  until hands[0].empty? || hands[1].empty? do
    p hands[0][0], hands[1][0]
    if hands[0][0] > hands[1][0]
      hands[0].push(hands[0].shift)
      hands[0].push(hands[1].shift)
    else
      hands[1].push(hands[1].shift)
      hands[1].push(hands[0].shift)
    end
    p hands
  end
  p hands
  calculte_score(hands[1].concat hands[0])
end

def calculte_score(cards)
  cards.reverse.each_with_index.reduce(0) { |score, (card, idx)| score + card * (idx + 1) }
end

def prepare_input(input)
  input.reduce([]) do |hands, line|
    case line
    when /Player/
      hands << []
    when /\d+/
      hands.last << line.strip.to_i
    else
      # do nothing
    end
    hands
  end
end

def read_input(file_path)
  File.readlines(file_path)
end

p solution(prepare_input(read_input('example_input')))
p solution(prepare_input(read_input('input')))
