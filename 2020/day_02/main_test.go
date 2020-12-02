package main

import "testing"

func TestParseEntry(t *testing.T) {
	tests := []struct {
		input    string
		expected entry
	}{
		{
			"1-3 a: abcde",
			entry{min: 1, max: 3, letter: "a", password: "abcde"},
		},
		{
			"1-3 b: cdefg",
			entry{min: 1, max: 3, letter: "b", password: "cdefg"},
		},
	}

	for _, test := range tests {
		actual := parseEntry(test.input)
		if actual.min != test.expected.min {
			t.Errorf("expected %d, got %d", test.expected.min, actual.min)
		}
		if actual.max != test.expected.max {
			t.Errorf("expected %d, got %d", test.expected.max, actual.max)
		}
		if actual.letter != test.expected.letter {
			t.Errorf("expected %s, got %s", test.expected.letter, actual.letter)
		}
		if actual.password != test.expected.password {
			t.Errorf("expected %s, got %s", test.expected.password, actual.password)
		}
	}
}

func TestIsValid(t *testing.T) {
	tests := []struct {
		entry    entry
		expected bool
	}{
		{
			entry{min: 1, max: 3, letter: "a", password: "abcde"},
			true,
		},
		{
			entry{min: 1, max: 3, letter: "b", password: "cdefg"},
			false,
		},
	}

	for i, test := range tests {
		if actual := test.entry.isValid(); actual != test.expected {
			t.Errorf("test %d: expected %t, got %t", i, test.expected, actual)
		}
	}
}

func TestLetterOccursOnce(t *testing.T) {
	tests := []struct {
		entry    entry
		expected bool
	}{
		{
			entry{min: 1, max: 3, letter: "a", password: "abcde"},
			true,
		},
		{
			entry{min: 1, max: 3, letter: "b", password: "cdefg"},
			false,
		},
		{
			entry{min: 2, max: 9, letter: "c", password: "ccccccccc"},
			false,
		},
	}

	for i, test := range tests {
		if actual := test.entry.letterOccursOnce(); actual != test.expected {
			t.Errorf("test %d: expected %t, got %t", i, test.expected, actual)
		}
	}
}
