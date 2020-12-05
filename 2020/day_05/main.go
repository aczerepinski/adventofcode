package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

type boardingPass struct {
	row    int
	column int
}

func (b boardingPass) String() string {
	return fmt.Sprintf("<boardingPass>row: %d, column%d", b.row, b.column)
}

func (b boardingPass) seatID() int {
	return (b.row * 8) + b.column
}

func main() {
	bytes, err := ioutil.ReadFile("./input.txt")
	if err != nil {
		panic("bad file path")
	}
	input := string(bytes)

	fmt.Printf("part one: %d\n", partOne(input))
	fmt.Printf("part two: %d\n", partTwo(input))
}

func partOne(input string) int {
	var maxSeatID int
	for _, line := range strings.Split(input, "\n") {
		pass := readBoardingPass(line)
		if pass.seatID() > maxSeatID {
			maxSeatID = pass.seatID()
		}
	}
	return maxSeatID
}

func partTwo(input string) int {
	seatingChart := [128][8]bool{}
	seatIDs := []int{}

	for _, line := range strings.Split(input, "\n") {
		pass := readBoardingPass(line)
		seatingChart[pass.row][pass.column] = true
		seatIDs = append(seatIDs, pass.seatID())
	}

	var emptySeats []int
	for i := 0; i <= 127; i++ {
		for j := 0; j <= 7; j++ {
			if !seatingChart[i][j] {
				id := (i * 8) + j
				emptySeats = append(emptySeats, id)
			}
		}
	}

	for _, seat := range emptySeats {
		if sliceContains(seatIDs, seat+1) && sliceContains(seatIDs, seat-1) {
			return seat
		}
	}

	return 0
}

func readBoardingPass(rawPass string) boardingPass {
	if len(rawPass) != 10 {
		panic(fmt.Sprintf("unexpected input %s", rawPass))
	}

	return boardingPass{
		column: parseColumn(rawPass[7:]),
		row:    parseRow(rawPass[:7]),
	}
}

func parseColumn(directions string) int {
	return parseDirections(directions, "L", 0, 7)
}

func parseRow(directions string) int {
	return parseDirections(directions, "F", 0, 127)
}

func parseDirections(directions, lower string, min, max int) int {
	for _, d := range directions {
		if string(d) == lower {
			max = max - ((max - min) / 2) - 1
		} else {
			min = min + ((max - min + 1) / 2)
		}
	}
	return min
}

func sliceContains(ints []int, q int) bool {
	for _, n := range ints {
		if n == q {
			return true
		}
	}
	return false
}
