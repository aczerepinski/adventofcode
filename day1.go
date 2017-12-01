package main

import (
	"fmt"
	"strconv"
)

// Captcha finds the sum of all digits that match the next digit in the list.
// The list is circular, so the digit after the last digit is the first digit
// in the list.
func Captcha(input string) int {
	var matches []int
	for i := 0; i < len(input); i++ {
		current := input[i]
		next := input[(i+1)%len(input)]
		if current == next {
			nInt, err := strconv.Atoi(string(current))
			if err != nil {
				fmt.Printf("could not convert %s to int: %v", string(current), err)
				return 0
			}
			matches = append(matches, nInt)
		}
	}
	return reduceInts(matches)
}

func reduceInts(ints []int) int {
	var sum int
	for _, n := range ints {
		sum += n
	}
	return sum
}
