package main

import (
	"fmt"
	"strconv"
)

// Captcha finds the sum of all digits that match the next digit in the list.
// The list is circular, so the digit after the last digit is the first digit
// in the list.
func Captcha(input string) int {
	comparisonDistance := 1
	return doCaptcha(input, comparisonDistance)
}

// CaptchaTwo finds the sum of digits that match a digit halfway around
// a circular list
func CaptchaTwo(input string) int {
	comparisonDistance := len(input) / 2
	return doCaptcha(input, comparisonDistance)
}

func doCaptcha(input string, comparisonDistance int) int {
	var (
		matches []int
		length  = len(input)
	)
	for i := 0; i < length; i++ {
		current := input[i]
		next := input[(i+comparisonDistance)%length]
		if current == next {
			currentInt, err := strconv.Atoi(string(current))
			if err != nil {
				fmt.Printf("could not convert %s to int: %v", string(current), err)
				return 0
			}
			matches = append(matches, currentInt)
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
