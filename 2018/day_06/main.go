package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

type coordinate struct {
	id int
	x  int
	y  int
}

func main() {
	b, err := ioutil.ReadFile("input.txt")
	if err != nil {
		panic(err)
	}
	input := string(b)
	fmt.Printf("Part 1: %d\n", largestNonInfiniteArea(input))
	fmt.Printf("Part 2: %d\n", sizeOfSafeRegion(input, 10000))
}

func largestNonInfiniteArea(input string) int {
	coordinates := parseInput(input)
	grid := plotCoordinates(coordinates)

	var maxN int

	for _, c := range coordinates {
		n, isInfinite := countOccurances(grid, c.id)
		if n > maxN && !isInfinite {
			maxN = n
		}
	}

	return maxN
}

func sizeOfSafeRegion(input string, regionCriteria int) int {
	cs := parseInput(input)
	_, max := findBounds(cs)
	grid := initialGrid(cs, max)

	var size int

	for x, column := range grid {
		for y, _ := range column {
			sum := sumOfManhattans(cs, coordinate{x: x, y: y})
			if sum < regionCriteria {
				size++
			}
		}
	}
	return size
}

func countOccurances(grid [][]int, id int) (int, bool) {
	var count int
	var isInfinite bool
	for i, column := range grid {
		for j, n := range column {
			if n == id {
				count++
				if i == 0 || i == (len(grid)-1) || j == 0 || j == (len(column)-1) {
					isInfinite = true
				}
			}
		}
	}
	return count, isInfinite
}

func plotCoordinates(cs []coordinate) [][]int {
	_, max := findBounds(cs)
	initial := initialGrid(cs, max)
	return fullGrid(initial, cs)
}

func initialGrid(cs []coordinate, max coordinate) [][]int {
	plot := make([][]int, max.x+1)
	for i, _ := range plot {
		plot[i] = make([]int, max.y+2)
	}

	for _, c := range cs {
		plot[c.x][c.y] = c.id
	}
	return plot
}

func fullGrid(initialGrid [][]int, cs []coordinate) [][]int {
	full := make([][]int, len(initialGrid))
	copy(full, initialGrid)
	for x, column := range full {
		for y, _ := range column {
			id := closest(cs, coordinate{x: x, y: y})
			full[x][y] = id
		}
	}
	return full
}

func findBounds(cs []coordinate) (min coordinate, max coordinate) {
	min = coordinate{x: cs[0].x, y: cs[0].y}
	for _, c := range cs {
		if c.x < min.x {
			min.x = c.x
		}
		if c.y < min.y {
			min.y = c.y
		}
		if c.x > max.x {
			max.x = c.x
		}
		if c.y > max.y {
			max.y = c.y
		}
	}
	return min, max
}

// returns id of coordinate in cs closest to c, or 0
// if two contenders are equally close
func closest(cs []coordinate, c coordinate) int {
	var (
		shortestID       int
		shortestDistance int
		isSet            bool
	)
	for _, current := range cs {
		if current.x == c.x && current.y == c.y {
			return current.id
		}
		distance := manhattanDistance(current, c)
		if !isSet {
			shortestDistance = distance
			shortestID = current.id
			isSet = true
		} else {
			if distance == shortestDistance {
				shortestID = 0
			} else if distance < shortestDistance {
				shortestDistance = distance
				shortestID = current.id
			}
		}
	}
	return shortestID
}

func sumOfManhattans(cs []coordinate, reference coordinate) int {
	var sum int
	for _, c := range cs {
		sum += manhattanDistance(c, reference)
	}
	return sum
}

func manhattanDistance(a, b coordinate) int {
	return abs(a.x-b.x) + abs(a.y-b.y)
}

func abs(n int) int {
	if n >= 0 {
		return n
	}
	return 0 - n
}

func parseInput(input string) []coordinate {
	cs := []coordinate{}
	lines := strings.Split(input, "\n")
	for i, line := range lines {
		if line == "" {
			continue
		}
		nums := strings.Split(line, ", ")
		y, _ := strconv.Atoi(nums[0])
		x, _ := strconv.Atoi(nums[1])
		cs = append(cs, coordinate{id: i + 1, x: x, y: y})
	}
	return cs
}
