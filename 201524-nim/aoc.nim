import std/strutils
import std/sequtils
import std/sugar
import std/algorithm

echo "Hello World"

type
    PresentGroup = object
        count: int
        sum: int
        quantumEntanglement: int

proc createGroup(count: int, sum: int, quantumEntanglement: int): PresentGroup =
    PresentGroup(count: count, sum: sum, quantumEntanglement: quantumEntanglement)

proc createDefaultGroup(): PresentGroup =
    createGroup(0, 0, 1)

proc cloneGroup(g: PresentGroup): PresentGroup =
    createGroup(g.count, g.sum, g.quantumEntanglement)

proc addToGroup(g: PresentGroup, i: int): PresentGroup =
    # g.count = g.count + 1
    # g.sum += i;
    # g.quantumEntanglement *= i;
    g

type
    PresentGroups = object
        groups: seq[PresentGroup]
        current: int

proc createPresentGroups(g1: PresentGroup, g2: PresentGroup, g3: PresentGroup, current: int): PresentGroups =
    var groups: seq[PresentGroup] = @[g1, g2, g3]
    PresentGroups(groups: groups, current: current)

proc createDefaultPresentGroup(): PresentGroups =
    createPresentGroups(createDefaultGroup(), createDefaultGroup(), createDefaultGroup(), 0)

proc clonePresentGroups(groups: PresentGroups): PresentGroups =
    createPresentGroups(cloneGroup(groups.groups[0]), cloneGroup(groups.groups[1]), cloneGroup(groups.groups[2]), groups.current)

type
    PresentQueueItem = object
        groups: seq[PresentGroup]
        remainingPresents: seq[int]

type
    PresentQueueItem2 = object
        group: PresentGroup
        remainingPresents: seq[int]

proc findGroupsRecursive(partitionSum: int, groups: var seq[PresentGroup], group: PresentGroup, remainingPresents: seq[int], level: int) = 
    if (level < 6):
        for present in remainingPresents:
            var currentSum = group.sum
            var newSum = currentSum + present
            if newSum < partitionSum:
                var newGroup = cloneGroup(group)
                var newRemainingPresents = remainingPresents.filter(x => x != present)
                newGroup = addToGroup(newGroup, present)

                if newSum == partitionSum:
                    groups.add(newGroup)

                if newSum < partitionSum:
                    findGroupsRecursive(partitionSum, groups, newGroup, newRemainingPresents, level + 1)

proc compareInts(a, b: int): int = 
    if a > b: 1
    elif a < b: -1
    else: 0

proc compareGroups(a, b: PresentGroup): int =
    var countCompare = compareInts(a.count, b.count)
    if(countCompare == 0): compareInts(a.quantumEntanglement, b.quantumEntanglement)
    else: countCompare

proc balancePresents(rows: seq[string], groupCount: int): int =
    var presents = reversed(rows.map(x => parseInt(x)))
    var sum = foldl(presents, a + b)
    var partitionSum = (sum / groupCount).int
    var groups: seq[PresentGroup] = @[];
    findGroupsRecursive(partitionSum, groups, createDefaultGroup(), presents, 0)
    var sortedGroups = sorted(groups, compareGroups)
    sortedGroups[0].quantumEntanglement;

proc readLines(): seq[string] = 
    let fileContent = readFile("input.txt")
    splitlines(fileContent)

var rows = readLines()
var result1 = balancePresents(rows, 3)
echo result1