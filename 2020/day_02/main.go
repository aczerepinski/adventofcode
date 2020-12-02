package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

type entry struct {
	min      int
	max      int
	letter   string
	password string
}

func (e entry) isValid() bool {
	var count int
	for _, l := range e.password {
		if string(l) == e.letter {
			count++
		}
	}
	return count >= e.min && count <= e.max
}

func (e entry) letterOccursOnce() bool {
	var count int
	if string(e.password[e.min-1]) == e.letter {
		count++
	}
	if string(e.password[e.max-1]) == e.letter {
		count++
	}
	return count == 1
}

func main() {
	bytes, err := ioutil.ReadFile("./input.txt")
	if err != nil {
		panic("bad file path")
	}
	input := string(bytes)

	var entries []entry
	for _, line := range strings.Split(input, "\n") {
		entries = append(entries, parseEntry(line))
	}

	fmt.Printf("part one: %d\n", partOne(entries))
	fmt.Printf("part two: %d\n", partTwo(entries))
}

func parseEntry(input string) entry {
	var e entry
	components := strings.Split(input, " ")
	if len(components) != 3 {
		panic(fmt.Sprintf("unexpected input %s", input))
	}
	minMax := strings.Split(components[0], "-")
	e.min, _ = strconv.Atoi(minMax[0])
	e.max, _ = strconv.Atoi(minMax[1])
	e.letter = components[1][:1]
	e.password = components[2]

	return e
}

func partOne(entries []entry) int {
	var count int
	for _, entry := range entries {
		if entry.isValid() {
			count++
		}
	}
	return count
}

func partTwo(entries []entry) int {
	var count int
	for _, entry := range entries {
		if entry.letterOccursOnce() {
			count++
		}
	}
	return count
}
