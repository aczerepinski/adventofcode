package main

import (
	"testing"
)

var testInput = `1, 1
1, 6
8, 3
3, 4
5, 5
8, 9
`

func TestLargestNotInfiniteArea(t *testing.T) {
	expected := 17
	if actual := largestNonInfiniteArea(testInput); actual != expected {
		t.Errorf("expected %d, got %d", expected, actual)
	}
}

func TestSizeOfSaveRegion(t *testing.T) {
	expected := 16
	if actual := sizeOfSafeRegion(testInput, 32); actual != expected {
		t.Errorf("expected %d, got %d", expected, actual)
	}
}

func TestCountOccurances(t *testing.T) {
	tests := []struct {
		id                 int
		expectedN          int
		expectedIsInfinite bool
	}{
		{1, 15, true},
		{2, 14, true},
		{3, 21, true},
		{4, 9, false},
		{5, 17, false},
	}
	coordinates := parseInput(testInput)
	grid := plotCoordinates(coordinates)
	for _, tc := range tests {
		actualN, actualIsInfinite := countOccurances(grid, tc.id)
		if tc.expectedN != actualN {
			t.Errorf("expected id %d to occur %d times, got %d", tc.id, tc.expectedN, actualN)
		}
		if tc.expectedIsInfinite != actualIsInfinite {
			t.Errorf("expected id %d to be %t, got %t", tc.id, tc.expectedIsInfinite, actualIsInfinite)
		}
	}

}

func TestParseInput(t *testing.T) {
	coordinates := parseInput(testInput)
	if len(coordinates) < 2 {
		t.Fatal("did not parse coordinates")
	}
	actual := coordinates[1]
	expected := coordinate{id: 2, x: 6, y: 1}
	if actual != expected {
		t.Errorf("expected %+v, got %+v", expected, actual)
	}
}

func TestClosest(t *testing.T) {
	cs := []coordinate{
		coordinate{id: 1, x: 1, y: 1},
		coordinate{id: 2, x: 1, y: 6},
		coordinate{id: 3, x: 8, y: 3},
		coordinate{id: 4, x: 3, y: 4},
		coordinate{id: 5, x: 5, y: 5},
		coordinate{id: 6, x: 8, y: 9},
	}

	tests := []struct {
		c        coordinate
		expected int
	}{
		{coordinate{x: 0, y: 0}, 1},
		{coordinate{x: 5, y: 2}, 5},
	}

	for i, tc := range tests {
		if actual := closest(cs, tc.c); actual != tc.expected {
			t.Errorf("test %d, expected %d, got %d", i, tc.expected, actual)
		}
	}
}

func TestManhattanDistance(t *testing.T) {
	tests := []struct {
		a        coordinate
		b        coordinate
		expected int
	}{
		{
			coordinate{x: 0, y: 0},
			coordinate{x: 2, y: 2},
			4,
		},
		{
			coordinate{x: 3, y: 3},
			coordinate{x: 2, y: 2},
			2,
		},
		{
			coordinate{x: 5, y: 5},
			coordinate{x: 5, y: 2},
			3,
		},
		{
			coordinate{x: 8, y: 3},
			coordinate{x: 5, y: 2},
			4,
		},
		{
			coordinate{x: 2, y: 5},
			coordinate{x: 5, y: 5},
			3,
		},
		{
			coordinate{x: 5, y: 2},
			coordinate{x: 1, y: 6},
			8,
		},
	}

	for _, tc := range tests {
		if actual := manhattanDistance(tc.a, tc.b); actual != tc.expected {
			t.Errorf("expected %d, got %d", tc.expected, actual)
		}
	}
}
