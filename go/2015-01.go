package main

import (
	"os"
)

func main() {
	runReal()
}

func run(s string) {
	floor := 0
	firstTimeInBasement := 0
	moves := 0
	i := 0
	chars := []rune(s)
	for i = 0; i < len(chars); i++ {
		c := chars[i]
		moves += 1
		if c == '(' {
			floor += 1
		} else {
			floor -= 1
		}
		if firstTimeInBasement == 0 && floor < 0 {
			firstTimeInBasement = moves
		}
	}
	println(floor)
	print(firstTimeInBasement)
}

func runReal() {
	input := readInput()
	run(input)
}

func readInput() string {
	dat, err := os.ReadFile("../input/2015-01.txt")
	check(err)
	return string(dat)
}

func check(e error) {
	if e != nil {
		panic(e)
	}
}
