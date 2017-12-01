package main

import (
	"testing"
)

func TestCaptcha(t *testing.T) {
	tests := []struct {
		input  string
		output int
	}{
		{"1122", 3},
		{"1111", 4},
		{"1234", 0},
		{"91212129", 9},
	}

	for i, test := range tests {
		if actual := Captcha(test.input); actual != test.output {
			t.Errorf("%d: expected %d, got %d", i, test.output, actual)
		}
	}
}
