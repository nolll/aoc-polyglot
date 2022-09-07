open System
open System.Text.RegularExpressions

type Part =
    struct
        val Character: char
        val Count: int
        new(character: char, count: int) = { Character = character; Count = count }
    end

let rec generateParts (s: string) lastchar charcount =
    let length = String.length s

    if length = 0 then
        seq { yield new Part(lastchar, charcount) }
    else
        let currentchar = s[0]

        seq {
            if currentchar <> lastchar then
                yield new Part(lastchar, charcount)
                yield! generateParts s[1..] currentchar 1
            else
                yield! generateParts s[1..] currentchar (charcount + 1)
        }

let createPart (s: string) =
    let c = s[0]
    let l = String.length s
    new Part(c, l)

let getParts (s: string) =
    let regex = new Regex("(.)\\1*")
    let matches = regex.Matches s
    let strings = Seq.map (fun x -> x.ToString()) matches
    Seq.map (createPart) strings

let generateString (part: Part) = $"{part.Count}{part.Character}"

let generateStringFromList parts =
    let s = ""
    let strings = Seq.map (generateString) parts

    String.concat "" strings

let rec nextString (s: string) (iterations: int) (iteration: int) : string =
    if iteration >= iterations then
        s
    else
        let parts = getParts s
        let newString = generateStringFromList parts
        let nextIteration = iteration + 1
        nextString newString iterations nextIteration

let lookAndSayGame input iterations = nextString input iterations 0

let input = "1113222113"

let result1 = lookAndSayGame input 40
let length1 = String.length result1
printfn "%A" length1

let result2 = lookAndSayGame input 50
let length2 = String.length result2
printfn "%A" length2
