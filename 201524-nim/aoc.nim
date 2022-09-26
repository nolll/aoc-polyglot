import std/strutils
import std/sequtils
import std/sugar
import std/algorithm

proc comb[T](a: openarray[T]; n: int; use: seq[bool]): seq[seq[T]] =
  result = newSeq[seq[T]]()
  var use = use
  if n <= 0: return
  for i in 0 .. a.high:
    if not use[i]:
      if n == 1:
        result.add(@[a[i]])
      else:
        use[i] = true
        for j in comb(a, n - 1, use):
          result.add(a[i] & j)

proc combinations[T](a: openarray[T], n: int): seq[seq[T]] =
  var use = newSeq[bool](a.len)
  comb(a, n, use)

proc findGroups(presents: seq[int], partitionSum: int): seq[seq[int]] =
    var count = 1
    while count < len(presents):
        var combinations = combinations(presents, count)
        var valid = combinations.filter(o => foldl(o, a + b) == partitionSum)
        if len(valid) > 0:
            return valid
        count += 1

    @[]

proc balancePresents(rows: seq[string], groupCount: int): int =
    var presents = reversed(rows.map(x => parseInt(x)))
    var sum = foldl(presents, a + b)
    var partitionSum = (sum / groupCount).int
    var groups = findGroups(presents, partitionSum)
    var entanglements = groups.map(x => foldl(x, a * b, 1))
    var sortedGroups = sorted(entanglements)
    sortedGroups[0];

proc readLines(): seq[string] = 
    let fileContent = readFile("input.txt")
    splitlines(fileContent)

var rows = readLines()

var result1 = balancePresents(rows, 3)
echo result1

var result2 = balancePresents(rows, 4)
echo result2