package main

import (
	"fmt"
	"io/ioutil"
	"regexp"
	"sort"
	"strings"
)

type instruction struct {
	step   string
	before string
}

func main() {
	instructions := parseInput("input.txt")
	fmt.Printf("Part 1: %s\n", sortInstructions(instructions))
}

func stepNames(is []instruction) []string {
	var names []string
	is = append(is, missingSteps(is)...)
	for _, i := range is {
		names = appendIfUnique(names, i.step)
	}
	return names
}

func sortInstructions(is []instruction) string {
	stepNames := stepNames(is)
	sort.Strings(stepNames)
	var sorted []string

OUTER:
	for {
		if len(stepNames) == 0 {
			return strings.Join(sorted, "")
		}

		for i, step := range stepNames {
			if !isBlocked(step, is) {
				sorted = append(sorted, step)
				stepNames = append(stepNames[:i], stepNames[i+1:]...)
				is = removeStep(is, step)
				continue OUTER
			}
		}
	}
}

func isBlocked(step string, is []instruction) bool {
	for _, i := range is {
		if i.before == step {
			return true
		}
	}
	return false
}

func removeStep(is []instruction, step string) []instruction {
	for idx, instruction := range is {
		if instruction.step == step || instruction.before == step {
			return removeStep(append(is[:idx], is[idx+1:]...), step)
		}
	}
	return is
}

func appendIfUnique(steps []string, step string) []string {
	for _, s := range steps {
		if s == step {
			return steps
		}
	}
	return append(steps, step)
}

func missingSteps(is []instruction) []instruction {
	var missing []instruction

OUTER:
	for _, i := range is {
		for _, j := range is {
			if j.step == i.before {
				continue OUTER
			}
		}
		missing = append(missing, instruction{step: i.before})
	}

	return missing
}

func parseInput(path string) []instruction {
	b, err := ioutil.ReadFile(path)
	if err != nil {
		panic(err)
	}
	var is []instruction
	regex := regexp.MustCompile(`Step ([A-Z]) must be finished before step ([A-Z])`)
	matches := regex.FindAllStringSubmatch(string(b), -1)
	for _, match := range matches {
		i := instruction{step: match[1], before: match[2]}
		is = append(is, i)
	}

	return is
}
