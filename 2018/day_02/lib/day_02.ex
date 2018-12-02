defmodule Day02 do
  def part_one(filepath) do
    {:ok, input} = File.read(filepath)
    
    {doubles, triples} = String.split(input, "\n")
      |> Enum.map(&(double_triple(&1)))
      |> Enum.reduce({0, 0}, fn {d, t}, {ad, at} -> {d + ad, t + at} end)

    doubles * triples
  end

  def part_two(input) do
    ids = String.split(input, "\n")
    {a, b} = find_matches(ids)
    Enum.zip(String.to_charlist(a), String.to_charlist(b))
    |> Enum.reduce([], fn {x,y}, acc ->
        if x == y, do: [x | acc], else: acc
      end)
    |> Enum.reverse()
    |> List.to_string()
  end

  defp find_matches([id | ids]) do
    case find_match(id, ids) do
      {a, b} -> {a, b}
      :no_match -> find_matches(ids)
    end
  end

  defp find_match(box_id, []) do
    :no_match
  end

  defp find_match(box_id, [other | others]) do
    if is_match?(box_id, other) do
      {box_id, other}
    else
      find_match(box_id, others)
    end
  end

  defp is_match?(a, b) do
    zipped = Enum.zip(String.to_charlist(a), String.to_charlist(b))
    mismatches = Enum.reduce_while(zipped, 0, fn {x, y}, acc ->
      acc = if x != y, do: acc + 1, else: acc
      if acc > 1 do
        {:halt, acc}
      else 
        {:cont, acc}
      end
    end)
    mismatches <= 1
  end

  def double_triple(box_id) do
    double_triple(String.to_charlist(box_id), %{})
  end

  defp double_triple([], counts) do
    values = Map.values(counts)
    doubles = if Enum.member?(values, 2), do: 1, else: 0
    triples = if Enum.member?(values, 3), do: 1, else: 0
    {doubles, triples}
  end

  defp double_triple([h|t], counts) do
    updated = if Map.has_key?(counts, h) do
      Map.update!(counts, h, &(&1 + 1))
    else
      Map.put(counts, h, 1)
    end
    double_triple(t, updated)
  end
end

{:ok, input} = File.read("./lib/input.txt")
IO.puts "Part One: #{Day02.part_one("./lib/input.txt")}"
IO.puts "Part Two: #{Day02.part_two(input)}"
