defmodule Day05 do
  @doc """
  Smallest POssible.

  ## Examples

      iex> Day05.smallest_possible("dabAcCaCBAcCcaDA")
      4

  """
  def smallest_possible(input) do
    list = String.codepoints(input)

    Enum.reduce((?A .. ?Z), length(list), fn letter, acc ->
      removed = remove_letter(list, letter)
        min(acc, reaction(removed) |> length)
    end)
  end

  @doc """
  Remaining Size.

  ## Examples

      iex> Day05.remaining_size("dabAcCaCBAcCcaDA")
      10

  """
  def remaining_size(input) do
    input
    |> String.codepoints()
    |> reaction
    |> length
  end

  defp remove_letter(list, letter) do
    Enum.filter(list, fn n ->
      n != List.to_string([letter]) &&
      n != String.downcase(List.to_string([letter]))
    end)
  end

  defp reaction(original) do
    modified = do_reaction(original, [])

    if length(modified) != length(original) do
      reaction(modified)
    else
      modified
    end
  end

  defp do_reaction([], processed) do
    processed |> Enum.reverse()
  end

  defp do_reaction([h|[]], processed) do
    [h|processed]
    |> Enum.reverse()
  end

  defp do_reaction([a | [b| rest ]], processed) do
    if should_be_removed(a, b) do
      do_reaction(rest, processed)
    else
      do_reaction([b | rest], [a | processed])
    end
  end

  defp should_be_removed(a, b) do
    a != b && String.downcase(a) == String.downcase(b)
  end
end
