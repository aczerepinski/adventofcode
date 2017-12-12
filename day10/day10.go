package main

import (
	"fmt"
	"strconv"
	"strings"
)

func partOne(input string, circleLength int) int {
	answer, _ := solve(partOneInput(input), circleLength, 1, partOneReturn)
	return answer
}

func partTwo(input string) string {
	_, answer := solve(partTwoInput(input), 256, 64, partTwoReturn)
	return answer
}

func solve(input []int, circleLen int, rounds int, returnFunc func([]int) (int, string)) (int, string) {
	currentPos := 0
	s := initSlice(circleLen)
	skipSize := 0
	for round := 0; round < rounds; round++ {
		for _, n := range input {
			toReverse := make([]int, n, n)
			for i := 0; i < n; i++ {
				index := (currentPos + i) % len(s)
				toReverse[i] = s[index]
			}
			for i := 0; i < n; i++ {
				sIndex := (currentPos + i) % len(s)
				revIndex := len(toReverse) - 1 - i
				s[sIndex] = toReverse[revIndex]
			}
			currentPos += (n + skipSize) % len(s)
			skipSize++
		}
	}
	return returnFunc(s)
}

func partOneInput(input string) []int {
	strings := strings.Split(input, ",")
	ints := []int{}
	for _, str := range strings {
		n, _ := strconv.Atoi(str)
		ints = append(ints, n)
	}
	return ints
}

func partTwoInput(input string) []int {
	runeVals := []int{}
	for _, s := range input {
		runeVals = append(runeVals, int(s))
	}
	return append(runeVals, 17, 31, 73, 47, 23)
}

func partOneReturn(slice []int) (int, string) {
	return (slice[0] * slice[1]), ""
}

func partTwoReturn(slice []int) (int, string) {
	var (
		xored int
		dense []int
		hex   []string
	)
	for i, n := range slice {
		xored = xored ^ n
		if (i+1)%16 == 0 {
			dense = append(dense, xored)
			xored = 0
		}
	}
	for _, n := range dense {
		hex = append(hex, fmt.Sprintf("%02x", n))
	}
	return 0, strings.Join(hex, "")
}

func initSlice(length int) []int {
	s := make([]int, length, length)
	for i := range s {
		s[i] = i
	}
	return s
}

func main() {
	input := "197,97,204,108,1,29,5,71,0,50,2,255,248,78,254,63"
	fmt.Printf("answer to part one is %d\n", partOne(input, 256))
	fmt.Printf("answer to part two is %s\n", partTwo(input))
}
