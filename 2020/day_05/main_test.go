package main

import "testing"

func TestReadBoardingPass(t *testing.T) {
	tests := []struct {
		rawPass string
		row     int
		column  int
		seatID  int
	}{
		{"BFFFBBFRRR", 70, 7, 567},
		{"FFFBBBFRRR", 14, 7, 119},
		{"BBFFBBFRLL", 102, 4, 820},
	}

	for _, tc := range tests {
		if pass := readBoardingPass(tc.rawPass); pass.seatID() != tc.seatID {
			t.Errorf("%s: %s", tc.rawPass, pass)
		}
	}
}
