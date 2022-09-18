import Base: isless

function getCalibrationMolecules(startMolecule, replacements)
    molecules = String[]
    for replacement in replacements
        newMolecules = expand(startMolecule, replacement)
        molecules = cat(molecules, newMolecules, dims=1)
    end
    unique(molecules)
end

# function stepsToMake(molecule)
#     steps = 0
#     while molecule != "e"
#         for replacement in _replacements
#             pos = molecule.IndexOf(replacement.Right, StringComparison.InvariantCulture)
#             if (pos >= 0)
#                 molecule = replaceFirst(molecule, replacement.Right, replacement.Left)
#                 steps++
#                 break
#             end
#         end
#     end

#     steps
# end

# function replaceFirst(text, search, replace)
#     pos = text.IndexOf(search, StringComparison.InvariantCulture)
#     if pos < 0
#         return text
#     end
#     string.Concat(text.Substring(0, pos), replace, text.Substring(pos + search.Length))
# end

function parseReplacement(s)
    parts = split(s, " => ")
    input = parts[1]
    output = parts[2]
    MoleculeReplacement(input, output)
end

function expand(inputMolecule, replacement)
    molecules = String[]
    staticParts = split(inputMolecule, replacement.left)
    if length(staticParts) < 2
        return String[]
    end

    numberOfReplacements = length(staticParts) - 1
    for i = 1:numberOfReplacements
        s = ""
        for j = 1:numberOfReplacements
            s = s * staticParts[j]
            newReplacement = i == j ? replacement.right : replacement.left
            s = s * newReplacement
        end

        s = s * last(staticParts)

        push!(molecules, s)
    end

    molecules
end

function readInput()
    file = open("input.txt", "r")
    readlines(file)
end

struct MoleculeReplacement
    left
    right
end

isless(a::MoleculeReplacement, b::MoleculeReplacement) = isless(a.right, b.right) || isless(length(a.right), length(b.right))

# targetMolecule = "HOH"
targetMolecule = "CRnCaCaCaSiRnBPTiMgArSiRnSiRnMgArSiRnCaFArTiTiBSiThFYCaFArCaCaSiThCaPBSiThSiThCaCaPTiRnPBSiThRnFArArCaCaSiThCaSiThSiRnMgArCaPTiBPRnFArSiThCaSiRnFArBCaSiRnCaPRnFArPMgYCaFArCaPTiTiTiBPBSiThCaPTiBPBSiRnFArBPBSiRnCaFArBPRnSiRnFArRnSiRnBFArCaFArCaCaCaSiThSiThCaCaPBPTiTiRnFArCaPTiBSiAlArPBCaCaCaCaCaSiRnMgArCaSiThFArThCaSiThCaSiRnCaFYCaSiRnFYFArFArCaSiRnFYFArCaSiRnBPMgArSiThPRnFArCaSiRnFArTiRnSiRnFYFArCaSiRnBFArCaSiRnTiMgArSiThCaSiThCaFArPRnFArSiRnFArTiTiTiTiBCaCaSiRnCaCaFYFArSiThCaPTiBPTiBCaSiThSiRnMgArCaF"
rows = readInput()
replacements = map(parseReplacement, rows)
sortedReplacements = sort(replacements, rev=true) # then by right

calibrationMolecules = getCalibrationMolecules(targetMolecule, replacements)
# print(calibrationMolecules)
print(length(calibrationMolecules))