import sys


def read(year, day):
    f = open(getFilename(year, day), 'r', encoding='utf-8')
    s = f.read()
    f.close()
    return s.strip()


def readLines(year, day):
    f = open(getFilename(year, day), 'r', encoding='utf-8')
    s = f.readlines()
    f.close()
    return s


def getFilename(year, day):
    if (len(day) == 1):
        day = f'0{day}'
    return f'../input/{year}-{day}.txt'
