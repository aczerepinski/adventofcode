defmodule Day02 do
  def part_one(input) do
    prepare_map(input)
    |> restore_program(12, 2)
    |> execute_instructions(0)
    |> Map.get(0)
  end

  def part_two(input) do
    prepare_map(input)
    |> part_two(0, 0)
  end

  defp part_two(_, 100, _), do: "ruh roh"

  defp part_two(program, noun, 99 = verb) do
    if output(program, noun, verb) == 19_690_720 do
      100 * noun + verb
    else
      part_two(program, noun + 1, 0)
    end
  end

  defp part_two(program, noun, verb) do
    if output(program, noun, verb) == 19_690_720 do
      100 * noun + verb
    else
      part_two(program, noun, verb + 1)
    end
  end

  defp output(program, noun, verb) do
    program
    |> restore_program(noun, verb)
    |> execute_instructions(0)
    |> Map.get(0)
  end

  defp restore_program(instructions, noun, verb) do
    instructions
    |> Map.put(1, noun)
    |> Map.put(2, verb)
  end

  defp execute_instructions(program, i) do
    case program[i] do
      1 ->
        val = program[program[i + 1]] + program[program[i + 2]]

        execute_instructions(
          Map.put(program, program[i + 3], val),
          i + 4
        )

      2 ->
        val = program[program[i + 1]] * program[program[i + 2]]

        execute_instructions(
          Map.put(program, program[i + 3], val),
          i + 4
        )

      99 ->
        program
    end
  end

  defp prepare_map(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Map.new(fn {v, k} -> {k, v} end)
  end
end

{:ok, input} = File.read("./lib/input.txt")
IO.inspect(Day02.part_one(input), label: "part one")
IO.inspect(Day02.part_two(input), label: "part two")
