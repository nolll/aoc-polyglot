package main

import (
	"crypto/md5"
	"os"
	"strconv"
)

func main() {
	input := readInput()

	result1 := findCoin(input, 5, 0)
	println(result1)

	result2 := findCoin(input, 6, result1)
	println(result2)
}

func findCoin(key string, leadingZeros int, skip int) int {
	index := skip
	isValidCoin := startsWithFiveZeros
	if leadingZeros == 6 {
		isValidCoin = startsWithSixZeros
	}
	for {
		hashedBytes := getMd5Hash(key + strconv.Itoa(index))

		if isValidCoin(hashedBytes) {
			return index
		}

		index += 1
	}
}

func startsWithFiveZeros(bytes [16]byte) bool {
	return bytes[0] == 0 && bytes[1] == 0 && bytes[2] < 10
}

func startsWithSixZeros(bytes [16]byte) bool {
	return bytes[0] == 0 && bytes[1] == 0 && bytes[2] == 0
}

func getMd5Hash(text string) [16]byte {
	hash := md5.Sum([]byte(text))
	return hash
}

func readInput() string {
	dat, err := os.ReadFile("input.txt")
	if err != nil {
		panic(err)
	}
	return string(dat)
}
