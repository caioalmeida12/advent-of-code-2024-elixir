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
  end

  def total_difference([left_values, right_values]) do
    [left_values, right_values]
    |> Enum.zip()
    |> Enum.reduce(0, fn {left, right}, acc ->
      abs(left - right) + acc
    end)
  end

  def similarity_scores([left_values, right_values]) do
    left_values
    |> Enum.reduce([], fn value, acc ->
      count =
        right_values
        |> Enum.count(&(&1 == value))

      similarity_score = count * value

      [similarity_score | acc]
    end)
    |> Enum.sum()
  end
end

# Task 1
Day01.read_file(:real)
|> Day01.treat_input()
|> Day01.total_difference()
|> IO.inspect()

# Task 2
Day01.read_file(:real)
|> Day01.treat_input()
|> Day01.similarity_scores()
|> IO.inspect()
