defmodule DayFourTest do
  use ExUnit.Case
  doctest DayFour

  test "tests validity of a given passphrase" do
    assert DayFour.validate("aa bb cc dd ee")
    refute DayFour.validate("aa bb cc dd aa")
    assert DayFour.validate("aa bb cc dd aaa")
	end

  test "counts valid passphrases given a newline separated list" do
    input = "aa bb cc dd ee
  aa bb cc dd aa
  aa bb cc dd aaa
  bb cc
  bb cc bb"
    assert DayFour.count_valids(input) == 3
  end

  test "disallows passphrases containing anagrams" do
    assert DayFour.validate_anagrams("abcde fghij")
    refute DayFour.validate_anagrams("abcde xyz ecdab")
    assert DayFour.validate_anagrams("a ab abc abd abf abj")
    assert DayFour.validate_anagrams("iiii oiii ooii oooi oooo")
    refute DayFour.validate_anagrams("oiii ioii iioi iiio")
  end

  test "counts valid non-anagram passphrases" do
    input = "abcde fghij
  abcde xyz ecdab
  a ab abc abd abf abj
  iiii oiii ooii oooi oooo
  oiii ioii iioi iiio"
    assert DayFour.count_anagram_free_valids(input) == 3
  end
end
