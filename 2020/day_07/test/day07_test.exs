defmodule Day07Test do
  use ExUnit.Case
  doctest Day07
  ExUnit.configure(timeout: :infinity)

  test "counts bags that can hold another bag" do
    {:ok, input} = File.read("./test_input.txt")
    assert Day07.outer_bag_possibilities(input, "shiny gold") == 4
  end

  test "counts bags required inside a target bag" do
    input = """
    shiny gold bags contain 2 dark red bags.
    dark red bags contain 2 dark orange bags.
    dark orange bags contain 2 dark yellow bags.
    dark yellow bags contain 2 dark green bags.
    dark green bags contain 2 dark blue bags.
    dark blue bags contain 2 dark violet bags.
    dark violet bags contain no other bags.
    """
    assert Day07.count_inner_bags(input, "shiny gold") == 126
  end

  test "parses a rule" do
    rule = "dark olive bags contain 3 faded blue bags, 4 dotted black bags."
    bag = Day07.parse_bag(rule)
    assert bag.adjective == "dark"
    assert bag.color == "olive"
    assert length(bag.can_hold) == 2
    [first | _] = bag.can_hold
    assert first.quantity == 3
    assert first.adjective == "faded"
    assert first.color == "blue"
  end

  test "determines if a bag can directly hold a target color" do
    all_bags = %{}
    bag = %Bag{can_hold: [%Bag{adjective: "shiny", color: "gold"}]}
    assert Day07.can_contain_target?(all_bags, bag, "shiny gold") == true
  end

  test "determines if a bag can indirectly hold a target color" do
    all_bags = %{
      "pale blue" => %Bag{can_hold: [%Bag{adjective: "dark", color: "red"}]},
      "dark red" => %Bag{can_hold: [%Bag{adjective: "shiny", color: "gold"}]}
    }
    bag = %Bag{can_hold: [%Bag{adjective: "pale", color: "blue"}]}
    assert Day07.can_contain_target?(all_bags, bag, "shiny gold") == true
  end

  test "admits defeat if a bag cannot hold the target color" do
    all_bags = %{
      "pale blue" => %Bag{can_hold: [%Bag{adjective: "dark", color: "red"}]},
      "dark red" => %Bag{can_hold: [%Bag{adjective: "shiny", color: "pink"}]}
    }
    bag = %Bag{can_hold: [%Bag{adjective: "pale", color: "blue"}]}
    assert Day07.can_contain_target?(all_bags, bag, "shiny gold") == false
  end
end
