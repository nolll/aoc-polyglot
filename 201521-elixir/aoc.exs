defmodule RpgCharacter do
    defstruct name: "", points: 0, damage: 0, armor: 0
end

defmodule RpgProperty do
    defstruct name: "", cost: 0, damage: 0, armor: 0
end

defmodule Aoc do
    def run() do
        boss = createBoss(104, 8, 1)
        propertyCombinations = getPropertyCombinations()
        lowestCostToWin = findLowest(propertyCombinations, boss)
        IO.puts(lowestCostToWin)
        highestCostToLose = findHighest(propertyCombinations, boss)
        IO.puts(highestCostToLose)
    end

    def findLowest(propertyCombinations, boss), do: findLowest(propertyCombinations, boss, 99999999999999)
    def findLowest([], _boss, lowest), do: lowest
    def findLowest(propertyCombinations, boss, lowest) do
        [head | tail] = propertyCombinations
        player = createPlayer(head)
        winner = runGame(player, boss)
        didPlayerWin = if winner.name == "Player", do: true, else: false
        newLowest = if didPlayerWin, do: min(lowest, cost(head)), else: lowest
        findLowest(tail, boss, newLowest)
    end

    def findHighest(propertyCombinations, boss), do: findHighest(propertyCombinations, boss, -1)
    def findHighest([], _boss, highest), do: highest
    def findHighest(propertyCombinations, boss, highest) do
        [head | tail] = propertyCombinations
        player = createPlayer(head)
        winner = runGame(player, boss)
        didBossWin = if winner.name == "Boss", do: true, else: false
        newHighest = if didBossWin, do: max(highest, cost(head)), else: highest
        findHighest(tail, boss, newHighest)
    end

    def cost(properties) do
        Enum.sum(Enum.map(properties, fn p -> p.cost end))
    end

    def runGame(player, boss), do: attack(player, boss)

    def attack(attacker, defender) do
        if(isAlive(defender)) do
            attack(hurt(defender, attacker.damage), attacker)
        else
            attacker
        end
    end

    def createPlayer(), do: createPlayer(0, 0)
    def createPlayer(damage, armor), do: createRpgCharacter("Player", 100, damage, armor)
    def createPlayer(properties) do
        damage = Enum.sum(Enum.map(properties, fn p -> p.damage end))
        armor = Enum.sum(Enum.map(properties, fn p -> p.armor end))
        createPlayer(damage, armor)
    end

    def createBoss(points, damage, armor), do: createRpgCharacter("Boss", points, damage, armor)

    def createRpgCharacter(name, points, damage, armor) do
        %RpgCharacter{name: name, points: points, damage: damage, armor: armor}
    end

    def createWeapons() do
        [
            createRpgProperty("Dagger", 8, 4, 0),
            createRpgProperty("Shortsword", 10, 5, 0),
            createRpgProperty("Warhammer", 25, 6, 0),
            createRpgProperty("Longsword", 40, 7, 0),
            createRpgProperty("Greataxe", 74, 8, 0)
        ]
    end

    def createArmor() do
        [
            createRpgProperty("Leather", 13, 0, 1),
            createRpgProperty("Chainmail", 31, 0, 2),
            createRpgProperty("Splintmail", 53, 0, 3),
            createRpgProperty("Bandedmail", 75, 0, 4),
            createRpgProperty("Platemail", 102, 0, 5)
        ]
    end

    def createRings() do
        [
            createRpgProperty("Damage +1", 25, 1, 0),
            createRpgProperty("Damage +2", 50, 2, 0),
            createRpgProperty("Damage +3", 100, 3, 0),
            createRpgProperty("Defense +1", 20, 0, 1),
            createRpgProperty("Defense +2", 40, 0, 2),
            createRpgProperty("Defense +3", 80, 0, 3)
        ]    
    end

    def createRpgProperty(name, cost, damage, armor) do
        %RpgProperty{name: name, cost: cost, damage: damage, armor: armor}
    end

    def isAlive(character), do: character.points > 0

    def hurt(character, attack) do
        damage = getDamage(attack, character.armor)
        points = character.points - damage;
        %{character | :points => points}
    end

    def getDamage(attack, armor) do
        damage = attack - armor
        if(damage > 0) do
            damage
        else
            1
        end
    end

    def getPropertyCombinations() do
        weaponCombinations = getWeaponCombinations()
        armorCombinations = getArmorCombinations()
        ringCombinations = getRingCombinations()
        combineWeapons([], weaponCombinations, armorCombinations, ringCombinations)
    end

    def combineWeapons(combinations, [], _armorCombinations, _ringCombinations), do: combinations
    def combineWeapons(combinations, weaponCombinations, armorCombinations, ringCombinations) do
        [head | tail] = weaponCombinations
        a = combineArmors(combinations, head, armorCombinations, ringCombinations)
        b = combineWeapons(combinations, tail, armorCombinations, ringCombinations)
        combinations ++ a ++ b
    end

    def combineArmors(combinations, _weaponCombination, [], _ringCombinations), do: combinations
    def combineArmors(combinations, weaponCombination, armorCombinations, ringCombinations) do
        [head | tail] = armorCombinations
        a = combineRings(combinations, weaponCombination, head, ringCombinations)
        b = combineArmors(combinations, weaponCombination, tail, ringCombinations)
        combinations ++ a ++ b
    end

    def combineRings(combinations, _weaponCombination, _armorCombination, []), do: combinations
    def combineRings(combinations, weaponCombination, armorCombination, ringCombinations) do
        [head | tail] = ringCombinations
        a = [weaponCombination ++ armorCombination ++ head]
        b = combineRings(combinations, weaponCombination, armorCombination, tail)
        combinations ++ a ++ b
    end

    def getWeaponCombinations() do
        weapons = createWeapons()
        Enum.map(weapons, fn weapon -> [weapon] end)
    end

    def getArmorCombinations() do
        armors = createArmor();
        combinations = Enum.map(armors, fn armor -> [armor] end)
        [[]] ++ combinations
    end

    def getRingCombinations() do
        rings = createRings();
        oneRingCombinations = Enum.map(rings, fn ring -> [ring] end)
        twoRingCombinations = combinations(2, rings);
        [[]] ++ oneRingCombinations ++ twoRingCombinations
    end

    defp combinations(0, _), do: [[]]
    defp combinations(_, []), do: []
    defp combinations(size, [head | tail]) do 
        (for elem <- combinations(size-1, tail), do: [head|elem]) ++ combinations(size, tail)
    end
end

Aoc.run()
