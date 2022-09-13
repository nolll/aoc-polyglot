@main def run: Unit = 
  println("Hello world!")
  println(msg)

def msg = "I was compiled by Scala 3. :)"

def cookieBakery(input: String): Unit
{
    var ingredients = parseIngredients(input);
    var combinations = getCombinations(ingredients.Count);
    var highestScore = 0;
    var highestScoreWith500Calories = 0;

    foreach (var combination in combinations)
    {
        var score = getScore(ingredients, combination);
        var calories = getCalories(ingredients, combination);
        if (score > highestScore)
            highestScore = score;

        if (calories == 500 && score > highestScoreWith500Calories)
            highestScoreWith500Calories = score;
    }
}

def getScore(ingredients List[CookieIngredient], percentages List[Int]): Int
{
    var capacity = 0;
    var durability = 0;
    var flavor = 0;
    var texture = 0;

    for (var i = 0; i < ingredients.Count; i++)
    {
        capacity += percentages[i] * ingredients[i].Capacity;
        durability += percentages[i] * ingredients[i].Durability;
        flavor += percentages[i] * ingredients[i].Flavor;
        texture += percentages[i] * ingredients[i].Texture;
    }

    capacity = capacity > 0 ? capacity : 0;
    durability = durability > 0 ? durability : 0;
    flavor = flavor > 0 ? flavor : 0;
    texture = texture > 0 ? texture : 0;

    return capacity * durability * flavor * texture;
}

def getCalories(ingredients: List[CookieIngredient], percentages: List[Int])
{
    var calories = 0;

    for (var i = 0; i < ingredients.Count; i++)
    {
        calories += percentages[i] * ingredients[i].Calories;
    }

    return calories > 0 ? calories : 0;
}

def getCombinations(depth: Int): List[List[Int]]
{
    const int min = 0;
    const int max = 100;

    var combinations = new List<List<int>>();

    if (depth == 2)
    {
        for (var a = min; a <= max; a++)
        {
            var b = max - a;
            if(a + b == max)
                combinations.Add(new List<int>{a, b});
        }
    }

    if (depth == 4)
    {
        for (var a = min; a <= max; a++)
        {
            for (var b = min; b <= max; b++)
            {
                for (var c = min; c <= max; c++)
                {
                    var d = max - a - b - c;
                    if (a + b + c + d == max)
                        combinations.Add(new List<int> { a, b, c, d });

                }
            }
        }
    }

    return combinations;
}

def parseIngredients(input: String): List[CookieIngredient]
{
    var rows = PuzzleInputReader.ReadLines(input);
    return rows.Select(ParseIngredient).ToList();
}

def parseIngredient(s: String): CookieIngredient
{
    var parts = s.Replace(":", "").Replace(",", "").Split(' ');
    var name = parts[0];
    var capacity = int.Parse(parts[2]);
    var durability = int.Parse(parts[4]);
    var flavor = int.Parse(parts[6]);
    var texture = int.Parse(parts[8]);
    var calories = int.Parse(parts[10]);
    return CookieIngredient(name, capacity, durability, flavor, texture, calories);
}

case class CookieIngredient(name: String, capacity: Int, durability: Int, flavor: Int, texture: Int, calories: Int)