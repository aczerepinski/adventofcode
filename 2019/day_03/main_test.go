package main

import "testing"

func TestIntersectionDistance(t *testing.T) {
	tests := []struct{
		input string
		expected int
	}{
		{
			input: "R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83",
			expected: 159,
		},
		{
			input: "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7",
			expected: 135,
		},
	}

	for i, tc := range tests {
		g := newGrid(tc.input)
		if actual := g.intersectionDistance(); actual != tc.expected {
			t.Errorf("test %d: expected %d, got %d", i, tc.expected, actual)
		}
	}
}

func TestStepsToIntersection(t *testing.T) {
	tests := []struct{
		input string
		expected int
	}{
		{
			input: "R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83",
			expected: 610,
		},
		{
			input: "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7",
			expected: 410,
		},
	}

	for i, tc := range tests {
		g := newGrid(tc.input)
		if actual := g.stepsToIntersection(); actual != tc.expected {
			t.Errorf("test %d: expected %d, got %d", i, tc.expected, actual)
		}
	}
}