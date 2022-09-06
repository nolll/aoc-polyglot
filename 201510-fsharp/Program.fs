open System

type Part =
    struct
        val character: char
        val count: int
    end

// let GenerateString (part: Part) = $"{part.count}{part.character}"

// let GenerateStringFromList parts =
//     let s = ""
//     let strings = List.iter (GenerateString) parts

//     String.concat "" strings

// let GetParts s = [ new Part('a', 0) ]

let NextString s iterations iteration = s
// if iteration >= iterations then
//     s
// else
//     NextString(GenerateStringFromList(GetParts(s)), iterations, iteration + 1)

let LookAndSayGame input iterations = NextString input iterations 0

let GetParts s = s |> Seq.countBy id

// let GetParts s
//     let stringlength = String.length s
//     let looplength = stringlength - 1
//     seq{
//         for i in 0..looplength do
//             let c = s[i]
//             for j in i..looplength

//     }
// private IList<Part> GetParts(string s)
// {
//     var parts = new List<Part>();
//     Part currentPart = null;
//     foreach (var c in s)
//     {
//         if (currentPart == null || c != currentPart.Character)
//         {
//             currentPart = new Part(c);
//             parts.Add(currentPart);
//         }

//         currentPart.Count++;
//     }

//     return parts;
// }

//let result = LookAndSayGame "1113222113" 40
//printfn "%s" result

let r = GetParts "1113222113"
let last = List.ofSeq r
let (a, b) = last
printfn a
