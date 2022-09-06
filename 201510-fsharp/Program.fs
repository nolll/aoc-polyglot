printfn "Hello from F#"

let GenerateString part = $"{part.count}{part.character}"

let GenerateStringFromList parts =
    let s = ""

    for part in parts do
        s = s + GenerateString(part)

let NextString s iterations iteration =
    if iteration >= iterations then
        s
    else
        NextString(GenerateStringFromList(GetParts(s)), iterations, iteration + 1)

let LookAndSayGame input iterations = NextString(input, iterations, 0)

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

type Part =
    struct
        val character: char
        val count: int
    end
