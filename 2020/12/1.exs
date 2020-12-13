defmodule Day12Part1 do
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
    |> Enum.reduce({@e, 0, 0}, &move(&2, &1))
    |> manhattan_distance
  end

  defp move({direct, x, y}, {@n, value}), do: {direct, x, y + value}
  defp move({direct, x, y}, {@s, value}), do: {direct, x, y - value}
  defp move({direct, x, y}, {@e, value}), do: {direct, x + value, y}
  defp move({direct, x, y}, {@w, value}), do: {direct, x - value, y}
  defp move({@n, x, y}, {"F", value}), do: {@n, x, y + value}
  defp move({@s, x, y}, {"F", value}), do: {@s, x, y - value}
  defp move({@e, x, y}, {"F", value}), do: {@e, x + value, y}
  defp move({@w, x, y}, {"F", value}), do: {@w, x - value, y}
  defp move({direct, x, y}, {"R", degree}) do
    {rem(direct + degree, 360), x, y}
  end
  defp move({direct, x, y}, {"L", degree}) do
    {rem(direct - degree + 360, 360), x, y}
  end

  defp manhattan_distance({_, x, y}), do: abs(x) + abs(y)

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

IO.inspect Day12Part1.solution(File.read!("./example_input"))
IO.inspect Day12Part1.solution(File.read!("./input"))
