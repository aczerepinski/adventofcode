package main

import "testing"

func TestIsValidPassword(t *testing.T) {
	tests := []struct{
		password int
		isValid bool
	}{
		{111111, true},
		{223450, false},
		{123789, false},
	}

	for _, test := range tests {
		if isValid := isValidPassword(test.password); isValid != test.isValid {
			t.Errorf("expected %d to be %t, got %t", test.password, test.isValid, isValid)
		}
	}
}

func TestIsActuallyValid(t *testing.T) {
	tests := []struct{
		password int
		isValid bool
	}{
		{112233, true},
		{123444, false},
		{111122, true},
	}

	for _, test := range tests {
		if isValid := isActuallyValid(test.password); isValid != test.isValid {
			t.Errorf("expected %d to be %t, got %t", test.password, test.isValid, isValid)
		}
	}
}