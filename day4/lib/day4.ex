defmodule DayFour do

  def validate(passphrase) do
    String.split(passphrase)
    |> is_unique?
  end

  def count_valids(input) do
    String.split(input, "\n")
    |> Enum.map(&(validate(&1)))
    |> Enum.reduce(0, &(increment_if_true(&1, &2)))
  end

  def validate_anagrams(passphrase) do
    String.split(passphrase)
    |> excludes_anagrams?
  end

  def count_anagram_free_valids(input) do
    String.split(input, "\n")
    |> Enum.map(&(validate_anagrams(&1)))
    |> Enum.reduce(0, &(increment_if_true(&1, &2)))
  end

  defp increment_if_true(bool, acc) do
    if bool, do: acc + 1, else: acc
  end

  defp is_unique?([head | tail]) do
    is_unique?(tail, [head])
  end

  defp is_unique?([head | tail], uniques) do
    if Enum.member?(uniques, head), do: false, else: is_unique?(tail, [head | uniques])
  end

  defp is_unique?([], _), do: true

  defp excludes_anagrams?([head | tail]) do
    excludes_anagrams?([head | tail], tail)
  end

  defp excludes_anagrams?([head | tail], [comp_head | comp_tail]) do
    if is_anagram?(head, comp_head) do
      false
    else
      excludes_anagrams?([head | tail], comp_tail)
    end
  end

  defp excludes_anagrams?([_ | tail], []) do
    if tail == [] do
      true
    else
      [_ | new_comp] = tail
      excludes_anagrams?(tail, new_comp)
    end
  end

  defp is_anagram?(a, b) do
    String.split(a, "") |> Enum.sort == String.split(b, "") |> Enum.sort
  end
end

{:ok, input} = File.read("input.txt")
IO.puts "Part One: #{DayFour.count_valids(input)}"
IO.puts "Part Two: #{DayFour.count_anagram_free_valids(input)}"