defmodule M do
  @mul ~r/mul\((\d{1,3}),(\d{1,3})\)/
  @dos ~r/do\(\)/
  @dont ~r/don't\(\)/

  def read_input, do: IO.read(:stdio, :eof)

  def main do
    x = read_input()

    muls = Regex.scan(@mul, x, return: :index) |> Enum.map(&tokenize(&1, x, :mul))
    dos = Regex.scan(@dos, x, return: :index) |> Enum.map(&tokenize(&1, :do))
    donts = Regex.scan(@dont, x, return: :index) |> Enum.map(&tokenize(&1, :dont))

    (muls ++ dos ++ donts)
    |> Enum.sort_by(fn {pos, _, _} -> pos end)
    |> process()
  end

  defp tokenize([{pos, _}], t), do: {pos, t, nil}

  defp tokenize([{pos, _} | n], x, :mul) do
    [a, b] =
      Enum.map(n, fn {pos, l} ->
        String.slice(x, pos, l) |> String.to_integer()
      end)

    {pos, :mul, {a, b}}
  end

  defp process(o) do
    o
    |> Enum.reduce({0, true}, fn
      {_, :do, _}, {a, _} -> {a, true}
      {_, :dont, _}, {a, _} -> {a, false}
      {_, :mul, {a, b}}, {c, s} -> if s, do: {c + a * b, s}, else: {c, s}
    end)
  end
end

M.main() |> elem(0) |> IO.puts()
