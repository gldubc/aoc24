defmodule Solver do
  def read_input do
    IO.read(:stdio, :eof)
    |> String.trim()
    |> String.split("\n")
    |> Enum.reduce({[], []}, fn line, {acc1, acc2} ->
      [a, b] = String.split(line) |> Enum.map(&String.to_integer/1)
      {[a | acc1], [b | acc2]}
    end)
  end

  def main do
    {list1, list2} = read_input()
    freq = Enum.frequencies(list2)
    Enum.reduce(list1, 0, fn x, acc -> acc + x * Map.get(freq, x, 0) end)
  end
end

Solver.main() |> IO.puts()
