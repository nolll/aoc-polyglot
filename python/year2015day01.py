#!/usr/bin/env python

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
