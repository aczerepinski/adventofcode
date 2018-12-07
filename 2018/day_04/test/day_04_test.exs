defmodule Day04Test do
  use ExUnit.Case
  doctest Day04

  test "solves part 1" do
    input = """
    [1518-11-01 00:05] falls asleep
    [1518-11-01 00:25] wakes up
    [1518-11-01 23:58] Guard #99 begins shift
    [1518-11-03 00:29] wakes up
    [1518-11-02 00:40] falls asleep
    [1518-11-05 00:03] Guard #99 begins shift
    [1518-11-03 00:24] falls asleep
    [1518-11-02 00:50] wakes up
    [1518-11-01 00:30] falls asleep
    [1518-11-01 00:55] wakes up
    [1518-11-01 00:00] Guard #10 begins shift
    [1518-11-05 00:55] wakes up
    [1518-11-04 00:46] wakes up
    [1518-11-03 00:05] Guard #10 begins shift
    [1518-11-04 00:02] Guard #99 begins shift
    [1518-11-04 00:36] falls asleep
    [1518-11-05 00:45] falls asleep
    """

    assert Day04.part_one(input) == 240
  end

  test "solves part 2" do
    input = """
    [1518-11-01 00:05] falls asleep
    [1518-11-01 00:25] wakes up
    [1518-11-01 23:58] Guard #99 begins shift
    [1518-11-03 00:29] wakes up
    [1518-11-02 00:40] falls asleep
    [1518-11-05 00:03] Guard #99 begins shift
    [1518-11-03 00:24] falls asleep
    [1518-11-02 00:50] wakes up
    [1518-11-01 00:30] falls asleep
    [1518-11-01 00:55] wakes up
    [1518-11-01 00:00] Guard #10 begins shift
    [1518-11-05 00:55] wakes up
    [1518-11-04 00:46] wakes up
    [1518-11-03 00:05] Guard #10 begins shift
    [1518-11-04 00:02] Guard #99 begins shift
    [1518-11-04 00:36] falls asleep
    [1518-11-05 00:45] falls asleep
    """

    assert Day04.part_two(input) == 4455

    input_2 = """
    [1518-11-01 23:58] Guard #50 begins shift
    [1518-11-02 00:05] falls asleep
    [1518-11-02 00:06] wakes up
    [1518-11-02 23:58] Guard #50 begins shift
    [1518-11-03 00:05] falls asleep
    [1518-11-03 00:06] wakes up
    [1518-11-03 23:58] Guard #50 begins shift
    [1518-11-04 00:05] falls asleep
    [1518-11-04 00:06] wakes up
    """

    assert Day04.part_two(input_2) == 50 * 5
  end
end