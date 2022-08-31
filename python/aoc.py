#!/usr/bin/env python

import inputreader
import sys
import year2015day01
import year2015day02


def main():
    year = sys.argv[1]
    day = sys.argv[2]

    input = inputreader.read(year, day)

    run(year, day, input)


def run(year, day, input):
    if (year == '2015'):
        if (day == '1'):
            year2015day01.run(input)
        elif (day == '2'):
            year2015day02.run(input)
        else:
            print(f'day {day} {year} not found')
    else:
        print(f'year {year} not found')


if __name__ == '__main__':
    main()
