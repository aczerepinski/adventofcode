defmodule DayEleven do
  def count_steps(input) do
    solve(String.split(input, ","))
  end

  def count_max(input) do
    list = String.split(input, ",")
    brute_force_max(list, length(list), 0)
  end

  defp brute_force_max(_, 0, max), do: max

  defp brute_force_max(list, len, max) do
    current_list = Enum.take(list, len)
    current_steps = solve(current_list)
    new_max = if current_steps > max, do: current_steps, else: max
    brute_force_max(list, len-1, new_max)
  end

  defp solve(list) do
    steps = %{
      "n" => 0,
      "ne" => 0,
      "se" => 0,
      "s" => 0,
      "sw" => 0,
      "nw" => 0,
      }
    list
    |> record_steps(steps)
    |> eliminate_dupes
    |> Enum.reduce(0, fn({_k, v}, acc) -> v + acc end)
  end

  defp record_steps([head | tail], steps) do
    record_steps(tail, Map.update!(steps, head, &(&1 + 1)))
  end

  defp record_steps([], steps), do: steps

  defp eliminate_dupes(steps) do
    steps
    |> cancel_opposites
    |> convert_diagonals
  end

  defp convert_diagonals(steps) do
    steps
    |> convert_diagonal("se", "sw", "s")
    |> convert_diagonal("s", "nw", "sw")
    |> convert_diagonal("sw", "n", "nw")
    |> convert_diagonal("nw", "ne", "n")
    |> convert_diagonal("n", "se", "ne")
    |> convert_diagonal("ne", "s", "se")
  end

  defp convert_diagonal(steps, a, b, sum) do
    amount_to_convert = if steps[a] < steps[b], do: steps[a], else: steps[b]
    steps
    |> Map.update!(a, &(&1 - amount_to_convert))
    |> Map.update!(b, &(&1 - amount_to_convert))
    |> Map.update!(sum, &(&1 + amount_to_convert))
  end

  defp cancel_opposites(steps) do
    steps
    |> cancel_opposite("ne", "sw")
    |> cancel_opposite("se", "nw")
    |> cancel_opposite("n", "s")
  end

  defp cancel_opposite(steps, a, b) do
    amount_to_cancel = if steps[a] < steps[b], do: steps[a], else: steps[b]
    steps
    |> Map.update!(a, &(&1 - amount_to_cancel))
    |> Map.update!(b, &(&1 - amount_to_cancel))
  end

end

{:ok, input} = File.read("input.txt")
IO.puts "Part One: #{DayEleven.count_steps(input)}"
IO.puts "Part Two: #{DayEleven.count_max(input)}"