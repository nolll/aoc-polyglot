import Base: isless

function getCalibrationMolecules(startMolecule, replacements)
    molecules = String[]
    for replacement in replacements
        newMolecules = expand(startMolecule, replacement)
        molecules = cat(molecules, newMolecules, dims=1)
    end
    unique(molecules)
end

function stepsToMake(molecule, replacements)
    steps = 0
    while molecule != "e"
        for replacement in replacements
            range = findfirst(replacement.right, molecule)
            if !(isnothing(range))
                molecule = replaceFirst(molecule, replacement.right, replacement.left)
                steps = steps + 1
                break
            end
        end
    end

    steps
end

function replaceFirst(text, search, replace)
    range = findfirst(search, text)
    if isnothing(range)
        text
    else
        pos = range[1]
        text[1:pos-1] * replace * text[pos+length(search):end]
    end
end

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

targetMolecule = "CRnCaCaCaSiRnBPTiMgArSiRnSiRnMgArSiRnCaFArTiTiBSiThFYCaFArCaCaSiThCaPBSiThSiThCaCaPTiRnPBSiThRnFArArCaCaSiThCaSiThSiRnMgArCaPTiBPRnFArSiThCaSiRnFArBCaSiRnCaPRnFArPMgYCaFArCaPTiTiTiBPBSiThCaPTiBPBSiRnFArBPBSiRnCaFArBPRnSiRnFArRnSiRnBFArCaFArCaCaCaSiThSiThCaCaPBPTiTiRnFArCaPTiBSiAlArPBCaCaCaCaCaSiRnMgArCaSiThFArThCaSiThCaSiRnCaFYCaSiRnFYFArFArCaSiRnFYFArCaSiRnBPMgArSiThPRnFArCaSiRnFArTiRnSiRnFYFArCaSiRnBFArCaSiRnTiMgArSiThCaSiThCaFArPRnFArSiRnFArTiTiTiTiBCaCaSiRnCaCaFYFArSiThCaPTiBPTiBCaSiThSiRnMgArCaF"
rows = readInput()
replacements = map(parseReplacement, rows)
sortedReplacements = sort(replacements, rev=true)

calibrationMolecules = getCalibrationMolecules(targetMolecule, replacements)
println(length(calibrationMolecules))

stepCount = stepsToMake(targetMolecule, replacements)
println(stepCount)