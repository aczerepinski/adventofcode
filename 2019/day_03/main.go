package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

type coordinate struct {
	x int
	y int
	steps int
}

func coordinatesForWire(rawInstructions string) []coordinate {
	var (
		x int
		y int
		steps int
		coordinates []coordinate
	)
	instructions := strings.Split(rawInstructions, ",")
	for _, instruction := range instructions {
		direction, distance := parseInstruction(instruction)
		switch direction {
		case "R":
			stop := x + distance
			for i := x; i <= stop; i++ {
				x = i
				coordinates = append(coordinates, coordinate{x: x, y: y, steps: steps})
				if i != stop {
					steps++
				}
			}
		case "L":
			stop := x - distance
			for i := x; i >= stop; i-- {
				x = i
				coordinates = append(coordinates, coordinate{x: x, y: y, steps: steps})
				if i != stop {
					steps++
				}
			}
		case "U":
			stop := y + distance
			for i := y; i <= stop; i++ {
				y = i
				coordinates = append(coordinates, coordinate{x: x, y: y, steps: steps})
				if i != stop {
					steps++
				}
			}
		case "D":
			stop := y - distance
			for i := y; i >= stop; i-- {
				y = i
				coordinates = append(coordinates, coordinate{x: x, y: y, steps: steps})
				if i != stop {
					steps++
				}
			}
		}
	}
	return coordinates
}

func parseInstruction(instruction string) (string, int) {
	direction := string([]rune(instruction)[0])
	num := string([]rune(instruction)[1:])
	distance, err := strconv.Atoi(num)
	if err != nil {
		panic("bad input")
	}
	return direction, distance
}

func newGrid(input string) grid {
	var g grid
	wireStrings := strings.Split(input, "\n")
	if len(wireStrings) < 2 {
		panic("not enough wires")
	}
	g.a = coordinatesForWire(wireStrings[0])
	g.b = coordinatesForWire(wireStrings[1])
	return g
}

type grid struct {
	a []coordinate
	b []coordinate
}

func (g grid) intersections() []coordinate {
	cs := []coordinate{}
	for _, c := range g.a {
		for _, d := range g.b {
			if c.x == d.x && c.y == d.y {
				cs = append(cs, coordinate{x: c.x, y: c.y, steps: c.steps + d.steps})
			}
		}
	}
	return cs
}

func main() {
	bytes, err := ioutil.ReadFile("./input.txt")
	if err != nil {
		panic("bad file path")
	}
	input := string(bytes)
	grid := newGrid(input)
	fmt.Printf("min distance intersection is %d\n", grid.intersectionDistance())
	fmt.Printf("min steps to intersection is %d\n", grid.stepsToIntersection())
}

func (g grid) intersectionDistance() int {
	var min = 999999999
	for _, c := range g.intersections() {
		if distance := manhattanDistance(c); distance != 0 && distance < min {
			min = distance
		}
	}
	return min
}

func (g grid) stepsToIntersection() int {
	var min = 999999999
	for _, c := range g.intersections() {
		if c.steps < min && c.steps > 0 {
			min = c.steps
		}
	}
	return min
}

func manhattanDistance(c coordinate) int {
	return abs(c.x) + abs(c.y)	
}

func indexOf(cs []coordinate, val coordinate) int {
	for i, c := range cs {
		if c == val {
			return i
		}
	}
	panic("val not in slice")
}

func abs(n int) int {
	if n < 0 {
		return -n
	}
	return n
}

