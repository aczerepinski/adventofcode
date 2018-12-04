defmodule Day03 do
  def contested_squares(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(&parse_claim/1)
    |> record_claims()
    |> count_claims("X")
  end

  def uncontested_claim(input) do
    parsed = String.split(input, "\n", trim: true)
    |> Enum.map(&parse_claim/1)

    claim_sizes = parsed |> Enum.reduce([], fn claim, acc ->
      [{claim.id, claim.width * claim.height} | acc]
    end)

    fabric = record_claims(parsed)

    {id, _} = Enum.find(claim_sizes, fn {id, size} -> 
      count_claims(fabric, id) == size
    end)

    id
  end

  defp parse_claim(line) do
    captures = Regex.run(~r/([0-9]+)\s@\s([0-9]+),([0-9]+)\:\s([0-9]+)x([0-9]+)/,
      line, capture: :all_but_first)
      |> Enum.map(fn(c) -> 
        {int, _} = Integer.parse(c)
        int
      end)

    %{
      id: Enum.at(captures, 0),
      left: Enum.at(captures, 1),
      top: Enum.at(captures, 2),
      width: Enum.at(captures, 3),
      height: Enum.at(captures, 4),
    }
  end

  defp record_claims(claims) do
    Enum.reduce(claims, %{}, fn c, acc ->
      Enum.reduce((c.left + 1)..(c.left + c.width), acc, fn left, acc ->
        Enum.reduce((c.top + 1)..(c.top + c.height), acc, fn top, acc ->
          if Map.has_key?(acc, {left, top}) do
            Map.replace!(acc, {left, top}, "X")
          else
            Map.put(acc, {left, top}, c.id)
          end
        end)
      end)
    end)
  end

  defp count_claims(map, n) do
    map
    |> Map.values()
    |> Enum.filter(fn id -> id == n end)
    |> length
  end
end

{:ok, input} = File.read("./lib/input.txt")
IO.puts "Part One: #{Day03.contested_squares(input)}"
IO.puts "Part Two: #{Day03.uncontested_claim(input)}"
