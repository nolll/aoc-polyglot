import System.IO
import qualified Data.Map as Map
import qualified Data.List as List

main = do
    content <- readInput
    let rows = lines content
    let sues = parseSues rows

    let suePart1 = findSuePart1 sues
    let suePart1Id = getSueId suePart1
    putStrLn suePart1Id

    let suePart2 = findSuePart2 sues
    let suePart2Id = getSueId suePart2
    putStrLn suePart2Id

findSuePart1 sues = head (List.filter isCorrectSuePart1 sues)

isCorrectSuePart1 sue = isEqualOrMissing "children" "3" sue &&
                        isEqualOrMissing "cats" "7" sue && 
                        isEqualOrMissing "samoyeds" "2" sue && 
                        isEqualOrMissing "pomeranians" "3" sue && 
                        isEqualOrMissing "akitas" "0" sue && 
                        isEqualOrMissing "vizslas" "0" sue && 
                        isEqualOrMissing "goldfish" "5" sue && 
                        isEqualOrMissing "trees" "3" sue && 
                        isEqualOrMissing "cars" "2" sue && 
                        isEqualOrMissing "perfumes" "1" sue

findSuePart2 sues = head (List.filter isCorrectSuePart2 sues)

isCorrectSuePart2 sue = isEqualOrMissing "children" "3" sue &&
                        isGreaterThanOrMissing "cats" "7" sue && 
                        isEqualOrMissing "samoyeds" "2" sue && 
                        isLessThanOrMissing "pomeranians" "3" sue && 
                        isEqualOrMissing "akitas" "0" sue && 
                        isEqualOrMissing "vizslas" "0" sue && 
                        isLessThanOrMissing "goldfish" "5" sue && 
                        isGreaterThanOrMissing "trees" "3" sue && 
                        isEqualOrMissing "cars" "2" sue && 
                        isEqualOrMissing "perfumes" "1" sue

isEqualOrMissing key value sue = case Map.lookup key sue of   
    Nothing -> True
    Just (v) -> if v == value
                then True
                else False

isGreaterThanOrMissing key value sue = case Map.lookup key sue of   
    Nothing -> True
    Just (v) -> isGreaterThan v value

isLessThanOrMissing key value sue = case Map.lookup key sue of   
    Nothing -> True
    Just (v) -> isLessThan v value

isGreaterThan a b = do
    let intA = read a :: Integer
    let intB = read b :: Integer
    if(intA > intB)
    then True
    else False

isLessThan a b = do
    let intA = read a :: Integer
    let intB = read b :: Integer
    if(intA < intB)
    then True
    else False

getSueId sue = case Map.lookup "id" sue of   
    Nothing -> "not found"
    Just (v) -> v

parseSues rows = map parseSue rows 

parseSue row = do
    let stripped = removePunctuation row
    let parts = words stripped
    let id = parts!!1
    let n1 = parts!!2
    let v1 = parts!!3
    let n2 = parts!!4
    let v2 = parts!!5
    let n3 = parts!!6
    let v3 = parts!!7
    Map.fromList [("id", id), (n1, v1), (n2, v2), (n3, v3)]

printSue sue = print sue

removePunctuation s = filter (not . (`elem` ",:")) s

readInput = do readFile ("./input.txt")
