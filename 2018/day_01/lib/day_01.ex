defmodule Day01 do
  def part_one(string_input) do
    String.split(string_input, "\n")
    |> Enum.map(&(parse_instruction(&1)))
    |> Enum.sum
  end

  def part_two(string_input) do
    list = String.split(string_input, "\n")
      |> Enum.map(&(parse_instruction(&1)))
    first_dup_result(list, list, 0, [0])
  end

  defp parse_instruction(instruction) do
    case Integer.parse(instruction) do
      :error ->
        0
      {int, _} ->
        int
    end
  end

  # when list is exhausted, start from beginning
  defp first_dup_result([], full_list, current_freq, results) do
    first_dup_result(full_list, full_list, current_freq, results)
  end

  defp first_dup_result([h|t], full_list, current_freq, results) do
    new_freq = current_freq + h
    if Enum.member?(results, new_freq) do
      new_freq
    else
      first_dup_result(t, full_list, new_freq, [new_freq|results])
    end
  end
end

{:ok, input} = File.read("./lib/input.txt")
IO.puts "Part One: #{Day01.part_one(input)}"
IO.puts "Part Two: #{Day01.part_two(input)}"
