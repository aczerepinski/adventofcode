defmodule Day04 do
  def part_one(input) do
    parsed_entries = parse_entries(input)

    {sleepiest_guard, _} =
      parsed_entries
      |> Map.to_list()
      |> Enum.max_by(fn {_, minutes} -> length(minutes) end)

    {target_minute, _, _, _} =
      parsed_entries[sleepiest_guard]
      |> Enum.sort()
      |> Enum.reduce({0, 0, 0, 0}, &most_asleep_minute/2)

    sleepiest_guard * target_minute
  end

  def part_two(input) do
    {id, {minute, _, _, _}} =
      parse_entries(input)
      |> Map.to_list()
      |> Enum.map(fn {guard_id, minutes} -> {guard_id, Enum.sort(minutes)} end)
      |> Enum.map(fn {guard_id, minutes} ->
        {guard_id, Enum.reduce(minutes, {0, 0, 0, 0}, &most_asleep_minute/2)}
      end)
      |> Enum.max_by(fn {_, {_, max_ct, _, _}} -> max_ct end)

    id * minute
  end

  defp most_asleep_minute(n, {max_n, max_ct, cur_n, cur_ct}) do
    if n == cur_n do
      if cur_ct >= max_ct do
        {n, cur_ct + 1, n, cur_ct + 1}
      else
        {max_n, max_ct, cur_n, cur_ct + 1}
      end
    else
      {max_n, max_ct, n, 1}
    end
  end

  defp parse_entries(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&first_parse/1)
    |> Enum.sort(&(NaiveDateTime.compare(&1.time, &2.time) == :lt))
    |> Enum.reduce(%{}, &record_entry/2)
    |> Map.delete(:fell_asleep)
    |> Map.delete(:current_guard)
  end

  defp first_parse(line) do
    [_, time, note] = String.split(line, ["[", "] "])
    {:ok, ndt} = NaiveDateTime.from_iso8601(time <> ":00")
    %{time: ndt, note: note}
  end

  defp record_entry(entry, acc) do
    case entry.note do
      "falls asleep" ->
        Map.put(acc, :fell_asleep, minute_from_ndt(entry.time))

      "wakes up" ->
        woke_up = minute_from_ndt(entry.time)

        acc.fell_asleep..(woke_up - 1)
        |> Enum.reduce(acc, fn n, acc ->
          Map.update(acc, acc.current_guard, [n], &[n | &1])
        end)

      _ ->
        [guard_id] = String.split(entry.note, ["Guard #", " begins shift"], trim: true)
        {id, _} = Integer.parse(guard_id)
        Map.put(acc, :current_guard, id)
    end
  end

  defp minute_from_ndt(ndt) do
    [_, m, _] = String.split(NaiveDateTime.to_string(ndt), ":")
    {minute, _} = Integer.parse(m)
    minute
  end
end

{:ok, input} = File.read("./lib/input.txt")
IO.puts("Part One: #{Day04.part_one(input)}")
IO.puts("Part Two: #{Day04.part_two(input)}")
