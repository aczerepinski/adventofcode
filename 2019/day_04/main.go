package main

import (
	"fmt"
	"strconv"
	"strings"
)

func main() {
	var (
		partOneCount int
		partTwoCount int
		start int = 108457
		end int = 562041
	)
	for i := start; i <= end; i++ {
		if isValidPassword(i) {
			partOneCount++
		}
		if isActuallyValid(i) {
			partTwoCount++
		}
	}
	fmt.Printf("there are %d valid passwords in range %d - %d\n", partOneCount, start, end)
	fmt.Printf("nope, there are ACTUALLY %d valid passwords in range %d - %d\n", partTwoCount, start, end)
}

func isValidPassword(pw int) bool {
	slice := slicePassword(pw)
	return isSixDigits(slice) &&
		containsRepeatedDigits(slice) &&
		doesNotDecrease(slice)
}

func isActuallyValid(pw int) bool {
	slice := slicePassword(pw)
	return isSixDigits(slice) &&
		containsTwoRepeatedDigits(slice) &&
		doesNotDecrease(slice)
}

func isSixDigits(pw []int) bool {
	return len(pw) == 6
}

func containsRepeatedDigits(pw []int) bool {
	for i := 1; i < len(pw); i++ {
		if pw[i] == pw[i-1] {
			return true
		}
	}
	return false
}

func containsTwoRepeatedDigits(pw []int) bool {
	currentNumber := pw[0]
	repeats := 1

	for i := 1; i <= len(pw); i++ {
		if i == len(pw) {
			return repeats == 2
		} else if pw[i] == currentNumber {
			repeats++
		} else if repeats == 2 {
			return true
		} else {
			currentNumber = pw[i]
			repeats = 1
		}
	}
	return false
}

func doesNotDecrease(pw []int) bool {
	for i := 1; i < len(pw); i++ {
		if pw[i] < pw[i-1] {
			return false
		}
	}
	return true	
}

func slicePassword(pw int) []int {
	strings := strings.Split(strconv.Itoa(pw), "")
	var ints []int
	for _, s := range strings {
		int, _ := strconv.Atoi(s)
		ints = append(ints, int)
	}
	return ints
}