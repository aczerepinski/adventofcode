defmodule Bag do
  defstruct quantity: 0, color: "", adjective: "", can_hold: []
end

defmodule Day07 do
  def outer_bag_possibilities(rules, target_color) do
    all_bags = prepare_bags(rules)
    Enum.count(Map.values(all_bags), fn bag ->
      can_contain_target?(all_bags, bag, target_color)
    end)
  end

  def count_inner_bags(rules, target_color) do
    bags = prepare_bags(String.trim(rules))
    bag = bags[target_color]
    count_inners(bags, [bag], 0)
  end

  defp count_inners(_, [], acc), do: acc

  defp count_inners(bags, [h | t], count) do
    quantity = Enum.reduce(h.can_hold, count, fn b, acc ->
      b.quantity + acc
    end)

    # replace head with bags that head can hold * quantity
    new = new_list(bags, t, h.can_hold)
    count_inners(bags, new, quantity)
  end

  defp new_list(_, acc, []), do: acc

  defp new_list(bags, acc, l = [h|_]) do
    new_list(bags, acc, l, h.quantity)
  end

  defp new_list(_, acc, [], _), do: acc

  defp new_list(bags, acc, [_ | t], 0) do
    first = List.first(t)
    if first do
      new_list(bags, acc, t, first.quantity)
    else
      acc
    end
  end

  defp new_list(bags, acc, l = [h | _], n) do
    bag = bags["#{h.adjective} #{h.color}"]
    new_list(bags, [bag | acc], l, n-1)
  end


  def can_contain_target?(all_bags, bag, target_color) do
    can_contain(all_bags, bag.can_hold, target_color) 
  end

  defp can_contain(_, [], _), do: false

  defp can_contain(bags, [h | t], target) do
  query = "#{h.adjective} #{h.color}"
    # directly
    if query == target do
      true
    # indirectly
    else
      if new_bag = bags[query] do
        can_contain(bags, t ++ new_bag.can_hold, target)
      else
        can_contain(bags, t, target)
      end
    end
  end

  def parse_bag(rule) do
    pattern = [" ", " bags contain "]
    [adjective, color, contents | _] = String.split(rule, pattern, parts: 3)
    other_bags = String.split(contents, ", ")
      |> Enum.map(&parse_other_bag/1)
      |> Enum.filter(fn bag -> bag end)
    %Bag{adjective: adjective, color: color, can_hold: other_bags}
  end

  defp parse_other_bag(rule) do
    [quantity, adjective, color | _rest] = String.split(rule)
    case quantity do
    "no" ->
      nil
    _ ->
      %Bag{
        quantity: String.to_integer(quantity),
        adjective: adjective,
        color: color
      }
    end
  end

  defp prepare_bags(rules) do
    String.split(rules, "\n")
    |> Enum.reduce(%{}, fn line, acc ->
      bag = parse_bag(line)
      key = "#{bag.adjective} #{bag.color}"
      Map.put(acc, key, bag)
    end)
  end
end

{:ok, input} = File.read("./input.txt")
IO.puts("part 1: #{Day07.outer_bag_possibilities(input, "shiny gold")}")
IO.puts("part 2: #{Day07.count_inner_bags(input, "shiny gold")}")