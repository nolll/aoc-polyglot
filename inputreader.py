import sys


def read():
    f = open(getFilename(), 'r', encoding='utf-8')
    s = f.read()
    f.close()
    return s.strip()


def readLines():
    f = open(getFilename(), 'r', encoding='utf-8')
    s = f.readlines()
    f.close()
    return s


def getFilename():
    inputFileName = sys.argv[0].replace('.py', '.txt')
    return f'input/{inputFileName}'
