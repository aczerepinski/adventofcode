package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func readFile(location string) string {
	b, err := ioutil.ReadFile(location)
	if err != nil {
		panic(err)
	}
	return string(b)
}

func partOne(input string) int {
	var (
		programs = parseInput(input)
		linked   []int
	)
	followLinks(0, programs, &linked)
	return len(linked)
}

func partTwo(input string) int {
	var (
		groups     []int
		allCounted []int
		programs   = parseInput(input)
	)

	for i := 0; i < len(programs); i++ {
		if !isAlreadyCounted(i, &allCounted) {
			followLinks(i, programs, &allCounted)
			groups = append(groups, i)
		}
	}
	return len(groups)
}

func parseInput(input string) [][]int {
	programs := [][]int{}
	lines := strings.Split(input, "\n")
	for _, line := range lines {
		parts := strings.Split(line, "<-> ")
		if len(parts) < 2 {
			panic("error parsing input")
		}
		stringInts := strings.Split(parts[1], ", ")
		var realInts []int
		for _, str := range stringInts {
			n, err := strconv.Atoi(str)
			if err != nil {
				panic(err)
			}
			realInts = append(realInts, n)
		}
		programs = append(programs, realInts)
	}
	return programs
}

func followLinks(currentIndex int, programs [][]int, linked *[]int) {
	if !isAlreadyCounted(currentIndex, linked) {
		*linked = append(*linked, currentIndex)
	}
	for _, n := range programs[currentIndex] {
		if !isAlreadyCounted(n, linked) {
			followLinks(n, programs, linked)
		}
	}
}

func isAlreadyCounted(n int, linked *[]int) bool {
	for _, counted := range *linked {
		if n == counted {
			return true
		}
	}
	return false
}

func main() {
	input := readFile("input.txt")
	fmt.Printf("part one is: %d\n", partOne(input))
	fmt.Printf("part two is: %d\n", partTwo(input))
}
