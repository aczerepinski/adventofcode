package main

import (
	"testing"
)

func TestPartOne(t *testing.T) {
	input := readFile("test_input.txt")
	expected := 6
	if actual := partOne(input); actual != expected {
		t.Errorf("expected part one to return %d, got %d", expected, actual)
	}
}

func TestPartTwo(t *testing.T) {
	input := readFile("test_input.txt")
	expected := 2
	if actual := partTwo(input); actual != expected {
		t.Errorf("expected part two to return %d, got %d", expected, actual)
	}
}
