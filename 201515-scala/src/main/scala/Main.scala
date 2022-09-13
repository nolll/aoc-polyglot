import scala.collection.mutable.ListBuffer

@main def run: Unit = 
    val rows = readInputLines()
    run(rows)

def run(rows: List[String]): Unit =
    var ingredients = parseIngredients(rows)
    var combinations = getCombinations(ingredients.length)
    var highestScore = 0
    var highestScoreWith500Calories = 0

    for (combination <- combinations) {
        var score = getScore(ingredients, combination)
        var calories = getCalories(ingredients, combination)
        if (score > highestScore)
            highestScore = score

        if (calories == 500 && score > highestScoreWith500Calories)
            highestScoreWith500Calories = score
    }

    println(highestScore)
    println(highestScoreWith500Calories)

def getScore(ingredients: List[CookieIngredient], percentages: List[Int]): Int =
    var capacity = 0
    var durability = 0
    var flavor = 0
    var texture = 0

    for (i <- 0 until ingredients.length) {
        val percentage = percentages(i)
        var ingredient = ingredients(i)
        capacity += percentage * ingredient.capacity
        durability += percentage * ingredient.durability
        flavor += percentage * ingredient.flavor
        texture += percentage * ingredient.texture
    }

    capacity = Math.max(capacity, 0)
    durability = Math.max(durability, 0)
    flavor = Math.max(flavor, 0)
    texture = Math.max(texture, 0)

    capacity * durability * flavor * texture

def getCalories(ingredients: List[CookieIngredient], percentages: List[Int]): Int =
    var calories = 0

    for (i <- 0 until ingredients.length) 
        calories += percentages(i) * ingredients(i).calories

    if (calories > 0) calories else 0

def getCombinations(depth: Int): List[List[Int]] =
    val min = 0
    val max = 100

    var combinations = new ListBuffer[List[Int]]()

    if (depth == 2) {
        for (a <- min to max) {
            var b = max - a
            if(a + b == max)
                combinations += List(a, b)
        }
    }

    if (depth == 4) {
        for (a <- min to max) {
            for (b <- min to max) {
                for (c <- min to max) {
                    var d = max - a - b - c
                    if (a + b + c + d == max)
                        combinations += List(a, b, c, d)
                }
            }
        }
    }

    combinations.toList

def parseIngredients(rows: List[String]): List[CookieIngredient] = rows.map(o => parseIngredient(o))

def parseIngredient(s: String): CookieIngredient =
    var parts = s.replace(":", "").replace(",", "").split(' ')
    var name = parts(0)
    var capacity = parts(2).toInt
    var durability = parts(4).toInt
    var flavor = parts(6).toInt
    var texture = parts(8).toInt
    var calories = parts(10).toInt
    CookieIngredient(name, capacity, durability, flavor, texture, calories)

def readInputLines(): List[String] = scala.io.Source.fromFile("input.txt").getLines.toList

case class CookieIngredient(name: String, capacity: Int, durability: Int, flavor: Int, texture: Int, calories: Int)