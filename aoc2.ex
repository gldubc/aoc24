defmodule Reader do
  def main do
    IO.read(:stdio, :eof)
    |> String.split("\n")
    |> Enum.map(fn line -> line |> String.split() |> Enum.map(&String.to_integer/1) end)
    |> Enum.count(&is_valid/1)
  end

  def is_valid(seq) do
    is_monotonous(seq) or
      Enum.any?(0..(length(seq) - 1), &is_monotonous(List.delete_at(seq, &1)))
  end

  defp is_monotonous(seq), do: is_increasing(seq) or is_decreasing(seq)

  def is_increasing([]), do: false
  def is_increasing([_]), do: true
  def is_increasing([a, b | r]) when a < b and abs(a - b) in 1..3, do: is_increasing([b | r])
  def is_increasing(_), do: false

  def is_decreasing([]), do: false
  def is_decreasing([_]), do: true
  def is_decreasing([a, b | r]) when a > b and abs(a - b) in 1..3, do: is_decreasing([b | r])
  def is_decreasing(_), do: false
end

Reader.main() |> IO.puts()
