#!/usr/bin/env python

import sys


def main():
    # runTests()
    runReal()


def run(lines):
    sum = 0
    for line in lines:
        parts = line.split('x')
        w = int(parts[0])
        h = int(parts[1])
        d = int(parts[2])
        sum += getRequiredPaper(w, h, d)
    print(sum)


def runReal():
    input = readInputLines()
    run(input)


def runTests():
    print(getRequiredPaper(2, 3, 4))  # 58
    print(getRequiredPaper(1, 1, 10))  # 43


def getRequiredPaper(w, h, d):
    a = w * h
    b = h * d
    c = w * d
    areas = [a, b, c]
    areas.sort()
    smallest = areas[0]
    return (a + b + c) * 2 + smallest


def readInputLines():
    f = open('2015-02.txt', 'r', encoding='utf-8')
    s = f.readlines()
    f.close()
    return s


if __name__ == '__main__':
    main()
