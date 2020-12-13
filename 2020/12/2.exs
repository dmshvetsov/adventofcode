defmodule Day12Part2 do
  # North degree value
  @n 0
  # South degree value
  @s 180
  # East degree value
  @e 90
  # West degree value
  @w 270

  def solution(input) do
    prepare_input(input)
    |> Enum.reduce({10, 1, 0, 0}, &move(&2, &1))
    |> manhattan_distance
  end

  defp move({dx, dy, x, y}, {@n, value}), do: {dx, dy + value, x, y}
  defp move({dx, dy, x, y}, {@s, value}), do: {dx, dy - value, x, y}
  defp move({dx, dy, x, y}, {@e, value}), do: {dx + value, dy, x, y}
  defp move({dx, dy, x, y}, {@w, value}), do: {dx - value, dy, x, y}
  defp move({dx, dy, x, y}, {"F", value}), do: {dx, dy, x + dx * value, y + dy * value}
  defp move({dx, dy, x, y}, {"R", 90}), do: {dy, -dx, x, y}
  defp move({dx, dy, x, y}, {"R", 180}), do: {-dx, -dy, x, y}
  defp move({dx, dy, x, y}, {"R", 270}), do: {-dy, dx, x, y}
  defp move({dx, dy, x, y}, {"L", 90}), do: {-dy, dx, x, y}
  defp move({dx, dy, x, y}, {"L", 180}), do: {-dx, -dy, x, y}
  defp move({dx, dy, x, y}, {"L", 270}), do: {dy, -dx, x, y}

  defp manhattan_distance({_, _, x, y}), do: abs(x) + abs(y)

  defp direct_to_degree("N"), do: @n
  defp direct_to_degree("S"), do: @s
  defp direct_to_degree("E"), do: @e
  defp direct_to_degree("W"), do: @w
  defp direct_to_degree(letf_right_forward), do: letf_right_forward

  defp prepare_input(input) do
    input
    |> String.trim
    |> String.split("\n")
    |> Enum.map(fn(line) -> String.split_at(line, 1) end)
    |> Enum.map(fn({direction, value}) -> {direct_to_degree(direction), String.to_integer(value)} end)
  end
end

IO.inspect Day12Part2.solution(File.read!("./example_input"))
IO.inspect Day12Part2.solution(File.read!("./input"))
