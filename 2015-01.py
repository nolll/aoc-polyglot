#!/usr/bin/env python

import sys


def main():
    # runTests()
    runReal()


def run(s):
    floor = 0
    for c in s:
        if c == '(':
            floor += 1
        else:
            floor -= 1
    print(floor)


def runReal():
    input = readInput()
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


def readInput():
    f = open('2015-01.txt', 'r', encoding='utf-8')
    s = f.read()
    f.close()
    return s


if __name__ == '__main__':
    main()
