#!/usr/bin/env python

import inputreader


def main():
    input = inputreader.readLines()
    run(input)


def run(lines):
    paper = 0
    ribbon = 0
    for line in lines:
        parts = line.split('x')
        w = int(parts[0])
        h = int(parts[1])
        d = int(parts[2])
        paper += getRequiredPaper(w, h, d)
        ribbon += getRequiredRibbon(w, h, d)
    print(paper)
    print(ribbon)


def getRequiredPaper(w, h, d):
    a = w * h
    b = h * d
    c = w * d
    areas = [a, b, c]
    areas.sort()
    smallest = areas[0]
    return (a + b + c) * 2 + smallest


def getRequiredRibbon(w, h, d):
    sides = [w, h, d]
    sides.sort()
    bow = w * h * d
    return (sides[0] + sides[1]) * 2 + bow


if __name__ == '__main__':
    main()
