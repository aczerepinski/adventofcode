require 'test/unit'
require './day6.rb'

class Tests < Test::Unit::TestCase
  def test_part_one
    input = get_input
    assert_equal(5, part_one(input))
  end

  def test_part_two
    input = get_input
    assert_equal(4, part_two(input))
  end

  def get_input
    file = File.open("test_input.txt", "r")
    input = file.read()
    file.close()
    input
  end
end
