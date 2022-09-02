#!/usr/bin/env ruby

def main
    input = readInput
    run(input)
end

def run(input)
    strings = input.split("\n")
    count1 = 0
    count2 = 0

    strings.each do |s|
        s.strip!
        if isNice1(s)
            count1 += 1
        end
        if isNice2(s)
            count2 += 1
        end
        a = isNice2(s)
    end
    puts(count1)
    puts(count2)
end

def isNice1(input)
    if containsForbiddenSubstrings(input)
        return false
    end

    if !containsRepeatedCharacter(input)
        return false
    end

    if getVowelCount(input) < 3
        return false
    end

    return true
end

def isNice2(input)
    if !containsRepeatingPair(input)
        return false
    end

    if !containsRepeatedCharacterWithOneCharacterBetween(input)
        return false
    end

    return true
end

def containsForbiddenSubstrings(input)
    if input.include? 'ab'
        return true
    end
    if input.include? 'cd'
        return true
    end
    if input.include? 'pq'
        return true
    end
    if input.include? 'xy'
        return true
    end
    return false
end

def containsRepeatedCharacter(input)
    lastChar = '-'
    chars = input.split('')
    chars.each do |c|
        if c == lastChar
            return true
        end

        lastChar = c
    end
    
    return false
end

def containsRepeatingPair(input)
    loopEnd = input.length - 2
    for i in 0..loopEnd do
        str = input[i, 2]
        firstOccurence = input.index(str)
        lastOccurence = input.rindex(str)
        diff = lastOccurence - firstOccurence

        if diff > 1
            return true
        end
    end

    return false
end

def containsRepeatedCharacterWithOneCharacterBetween(input)
    loopEnd = input.length - 2
    for i in 0..loopEnd do
        str = input[i, 3]
        if str[0] == str[2]
            return true
        end
    end

    return false
end

def getVowelCount(input)
    chars = input.split('')
    count = 0
    chars.each do |c|
        if isVowel(c)
            count += 1
        end
    end
    return count
end

def isVowel(c)
    return 'aeiou'.include? c
end

def readInput
    file = File.open('input.txt')
    data = file.read
	return data
end

main