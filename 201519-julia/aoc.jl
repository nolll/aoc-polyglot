print("Hello World")

_replacements = PuzzleInputReader.ReadLines(input).Select(ParseReplacement).OrderByDescending(o => o.Right.Length).ThenBy(o => o.Right)

getCalibrationMolecules(startMolecule)
    molecules = string[]
    for replacement in _replacements
        molecules.AddRange(replacement.Expand(startMolecule))
    end
    molecules.Distinct().ToList()
end

stepsToMake(molecule)
    steps = 0
    while molecule != "e"
        for replacement in _replacements
            pos = molecule.IndexOf(replacement.Right, StringComparison.InvariantCulture)
            if (pos >= 0)
            {
                molecule = ReplaceFirst(molecule, replacement.Right, replacement.Left)
                steps++
                break
            }
        end
    end

    steps
end

replaceFirst(text, search, replace)
    pos = text.IndexOf(search, StringComparison.InvariantCulture)
    if pos < 0
        return text
    string.Concat(text.Substring(0, pos), replace, text.Substring(pos + search.Length))
end

parseReplacement(s)
    parts = s.Split(" => ")
    input = parts[0]
    output = parts[1]
    new MoleculeReplacement(input, output)
end

expand(inputMolecule, replacement)
    molecules = string[]
    staticParts = inputMolecule.Split(Left)
    if staticParts.Length < 2
        return string[]

    numberOfReplacements = staticParts.Length - 1
    for i = 0:numberOfReplacements
        sb = new StringBuilder()
        for j = 0:numberOfReplacements
            sb.Append(staticParts[j])
            newReplacement = i == j ? Right : Left
            sb.Append(newReplacement)
        end

        sb.Append(staticParts.Last())

        molecules.Add(sb.ToString())
    end

    molecules
end

struct MoleculeReplacement
    left
    right
end
