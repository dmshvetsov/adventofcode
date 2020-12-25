MOD = 20201227

def solution(cpkey, dpkey)
  card_loop_size = find_loopsize(cpkey)
  transform(card_loop_size, dpkey)
end

def transform(loop_size, subj_num = 7, mod_base = MOD)
  loop_size.times.reduce(1) do |val|
    (val * subj_num) % mod_base
  end
end

def find_loopsize(key, subj_num = 7, mod_base = MOD)
  loop_size = 0
  val = 1
  loop do
    loop_size += 1
    val = (val * subj_num) % mod_base
    return loop_size if val == key
  end
end

puts "Example: #{solution(5764801, 17807724)}"
puts "Solution: #{solution(3248366, 4738476)}"
