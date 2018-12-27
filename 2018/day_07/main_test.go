package main

import (
	"testing"
)

func TestParseInput(t *testing.T) {
	parsed := parseInput("test_input.txt")
	if len(parsed) < 1 {
		t.Fatal("failed to parse input")
	}
	i := parsed[0]
	if i.step != "C" || i.before != "A" {
		t.Errorf("expected {step: C, before: A}, got %+v", i)
	}
}

func TestMissingSteps(t *testing.T) {
	is := []instruction{
		instruction{step: "A", before: "B"},
		instruction{step: "B", before: "C"},
	}

	expected := []instruction{
		instruction{step: "C"},
	}

	actual := missingSteps(is)
	if len(actual) != len(expected) {
		t.Errorf("expected %d missing instructions, got %d", len(expected), len(actual))
	}
}

func TestSortInstructions(t *testing.T) {
	is := []instruction{
		instruction{step: "C", before: "A"},
		instruction{step: "C", before: "F"},
		instruction{step: "A", before: "B"},
		instruction{step: "A", before: "D"},
		instruction{step: "B", before: "E"},
		instruction{step: "D", before: "E"},
		instruction{step: "F", before: "E"},
	}
	expected := "CABDFE"
	if actual := sortInstructions(is); actual != expected {
		t.Errorf("expected %s, got %s", expected, actual)
	}
}
