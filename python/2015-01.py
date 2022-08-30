#!/usr/bin/env python

import sys
import inputreader


def main():
    # runTests()
    runReal()


def run(s):
    floor = 0
    firstTimeInBasement = 0
    moves = 0
    for c in s:
        moves += 1
        if c == '(':
            floor += 1
        else:
            floor -= 1
            if firstTimeInBasement == 0 and floor < 0:
                firstTimeInBasement = moves
    print(floor)
    print(firstTimeInBasement)


def runReal():
    input = inputreader.read()
    run(input)


def runTests():
    run('(())')  # 0
    run('()()')  # 0
    run('(((')  # 3
    run('(()(()(')  # 3
    run('))(((((')  # 3
    run('())')  # -1
    run('))(')  # -1
    run(')))')  # -3
    run(')())())')  # -3


if __name__ == '__main__':
    main()
