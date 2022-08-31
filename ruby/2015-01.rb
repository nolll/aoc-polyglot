#!/usr/bin/env ruby

def main()
    input = readInput()
    run(input)
end

def run(s)
    floor = 0
    firstTimeInBasement = 0
    moves = 0
    chars = s.split('')
    chars.each { |c|
        moves += 1
        if c == '('
            floor += 1
        else
            floor -= 1
            if firstTimeInBasement == 0 and floor < 0
                firstTimeInBasement = moves
            end
        end 
    }
    puts(floor)
    puts(firstTimeInBasement)
end

def readInput()
    file = File.open("../input/2015-01.txt")
    data = file.read
	return data
end

main()