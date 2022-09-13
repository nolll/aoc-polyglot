import scala.collection.mutable.ListBuffer

@main def run: Unit = 
    val rows = readInputLines()
    run(rows)

def run(rows: List[String]): Unit = {
    var ingredients = parseIngredients(rows);
    var combinations = getCombinations(ingredients.length);
    var highestScore = 0;
    var highestScoreWith500Calories = 0;

    for (combination <- combinations)
    {
        var score = getScore(ingredients, combination);
        var calories = getCalories(ingredients, combination);
        if (score > highestScore)
            highestScore = score;

        if (calories == 500 && score > highestScoreWith500Calories)
            highestScoreWith500Calories = score;
    }

    println(highestScore)
    println(highestScoreWith500Calories)
}

def getScore(ingredients: List[CookieIngredient], percentages: List[Int]): Int = {
    var capacity = 0;
    var durability = 0;
    var flavor = 0;
    var texture = 0;

    for (i <- 0 until ingredients.length)
    {
        capacity += percentages(i) * ingredients(i).capacity
        durability += percentages(i) * ingredients(i).durability
        flavor += percentages(i) * ingredients(i).flavor
        texture += percentages(i) * ingredients(i).texture
    }

    capacity = if (capacity > 0) capacity else 0
    durability = if (durability > 0) durability else 0
    flavor = if (flavor > 0) flavor else 0
    texture = if (texture > 0) texture else 0

    return capacity * durability * flavor * texture;
}

def getCalories(ingredients: List[CookieIngredient], percentages: List[Int]): Int = {
    var calories = 0;

    for (i <- 0 until ingredients.length)
    {
        calories += percentages(i) * ingredients(i).calories;
    }

    if (calories > 0) calories else 0
}

def getCombinations(depth: Int): List[List[Int]] = {
    val min = 0;
    val max = 100;

    var combinations = new ListBuffer[List[Int]]();

    if (depth == 2)
    {
        for (a <- min to max)
        {
            var b = max - a;
            if(a + b == max)
                combinations += List(a, b);
        }
    }

    if (depth == 4)
    {
        for (a <- min to max)
        {
            for (b <- min to max)
            {
                for (c <- min to max)
                {
                    var d = max - a - b - c;
                    if (a + b + c + d == max)
                        combinations += List(a, b, c, d);

                }
            }
        }
    }

    return combinations.toList
}

def parseIngredients(rows: List[String]): List[CookieIngredient] = {
    return rows.map(o => parseIngredient(o));
}

def parseIngredient(s: String): CookieIngredient = {
    var parts = s.replace(":", "").replace(",", "").split(' ');
    var name = parts(0);
    var capacity = parts(2).toInt;
    var durability = parts(4).toInt;
    var flavor = parts(6).toInt;
    var texture = parts(8).toInt;
    var calories = parts(10).toInt;
    return CookieIngredient(name, capacity, durability, flavor, texture, calories);
}

def readInputLines(): List[String] = {
    scala.io.Source.fromFile("input.txt").getLines.toList
}

case class CookieIngredient(name: String, capacity: Int, durability: Int, flavor: Int, texture: Int, calories: Int)