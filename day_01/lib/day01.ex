defmodule Day01 do
  @input_line_break "\r\n"

  def read_file(), do: read_file("./lib/example_input.txt")
  def read_file(:example_2), do: read_file("./lib/example_input_2.txt")
  def read_file(:real), do: read_file("./lib/input.txt")

  def read_file(path) do
    case File.read(path) do
      {:ok, result} -> result |> String.split(@input_line_break)
      {:error, error} -> IO.inspect(error)
    end
  end

  def treat_input(input_list_of_strings) do
    input_list_of_strings
    |> Enum.map(fn line ->
      [left, right] =
        String.split(line, "   ")

      [String.to_integer(left), String.to_integer(right)]
    end)
    |> Enum.reduce(%{left: [], right: []}, fn [left, right], cols ->
      cols
      |> Map.put(:left, [left | cols.left])
      |> Map.put(:right, [right | cols.right])
    end)
    |> then(fn %{left: left_values, right: right_values} ->
      [Enum.sort(left_values), Enum.sort(right_values)]
    end)
    |> Enum.zip()
  end

  def total_difference(list_of_tuples) do
    list_of_tuples
    |> Enum.reduce(0, fn {left, right}, acc ->
      abs(left - right) + acc
    end)
  end
end

Day01.read_file(:real)
|> Day01.treat_input()
|> Day01.total_difference()
|> IO.inspect()
