defmodule Day01 do
  def part_one(input) do
    String.split(input, "\n", trim: true)
    |> Enum.reduce(0, fn mass, acc ->
      acc + required_fuel(String.to_integer(mass))
    end)
  end

  def part_two(input) do
    String.split(input, "\n", trim: true)
    |> Enum.reduce(0, fn mass, acc ->
      acc + recursive_fuel(String.to_integer(mass))
    end)
  end

  def required_fuel(mass) do
    div(mass, 3) - 2
  end

  def recursive_fuel(mass), do: do_recursive_fuel(mass, 0)

  defp do_recursive_fuel(mass, acc) do
    case required_fuel(mass) do
      n when n <= 0 ->
        acc

      n ->
        do_recursive_fuel(n, acc + n)
    end
  end
end

{:ok, input} = File.read("./lib/input.txt")
IO.puts(Day01.part_one(input))
IO.puts(Day01.part_two(input))
