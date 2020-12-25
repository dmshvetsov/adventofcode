local stringy = require 'stringy'

function solution(data)
  local cur_mask = ''
  local mem = {}
  for _, line in pairs(data) do
    cmd_or_adr, value = table.unpack(line)
    if cmd_or_adr == 'mask' then
      cur_mask = value
    else
      local masked_bits = {}
      local bits = tobits(value)
      for bit_idx = 1, #cur_mask do
        local mask_bit = cur_mask[#cur_mask + 1 - bit_idx]
        if mask_bit ~= 'X' then
          table.insert(masked_bits, 1, tonumber(mask_bit))
        else
          table.insert(masked_bits, 1, bits[#bits + 1 - bit_idx] or 0)
        end
      end

      mem[cmd_or_adr] = tovalue(masked_bits)
    end
  end
  return reduce(mem, function(acc, val) return acc + val end, 0)
end

-- Utility functions

function prepare_input(file_path)
  local lines = {}
  for line in io.lines(file_path) do
    local cmd, val = table.unpack(
      map(stringy.split(line, '='), function(item) return stringy.strip(item) end)
    )
    if cmd == 'mask' then
      val = totable(val)
      table.insert(lines, { cmd, val })
    else
      local adr = tonumber(string.match(cmd, '%d+'))
      val = tonumber(val)
      table.insert(lines, { adr, val })
    end
  end
  return lines
end

function map(it, f)
  local rt = {}
  for key, val in pairs(it) do
    rt[key] = f(val)
  end
  return rt
end

function reduce(it, f, rt)
  for k, v in pairs(it) do
    rt = f(rt, v, k)
  end
  return rt
end

function tobits(num)
  if num == 0 then return {0} end
  local t = {}
  while num > 0 do
    rest = num % 2
    table.insert(t, 1, math.floor(rest))
    num = (num-rest) / 2
  end
  return t
end

function tovalue(bits)
  local res = 0
  for pow = 0, #bits - 1 do
    res = res + (bits[#bits - pow] * (2 ^ pow))
  end
  return math.floor(res)
end

function totable(str)
  local t = {}
  str:gsub(".",function(c) table.insert(t,c) end)
  return t
end

function pptable(t)
  local res = ''
  for _, value in pairs(t) do
    res = res .. ', ' .. value
  end
  return res
end

print("Example: " .. solution(prepare_input('./example_input_part1.txt')))
print("Puzzle: " .. solution(prepare_input('./input.txt')))
