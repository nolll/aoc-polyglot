fun main() {
    val input = "hxbxwxba"
    val pwd1 = findNextPassword(input)
    println(pwd1)

    val pwd2 = findNextPassword(pwd1)
    println(pwd2)
}

fun isValid(pwd: String): Boolean {
    if (containsForbiddenCharacters(pwd))
        return false

    if (!containsTwoPairs(pwd))
        return false

    if (!containsSequence(pwd))
        return false

    return true
}

fun findNextPassword(pwd: String): String {
    var nextPwd = pwd
    do
    {
        nextPwd = next(nextPwd)
    } while (!isValid(nextPwd))

    return nextPwd
}

fun next(pwd: String): String {
    var chars = pwd.toCharArray()
    var i = chars.size - 1
    while (chars[i] == 'z')
    {
        chars[i] = 'a'
        i--
    }

    chars[i] = chars[i] + 1

    return chars.concatToString()
}

fun containsForbiddenCharacters(pwd: String): Boolean {
    return pwd.contains('i') || pwd.contains('o') || pwd.contains('l')
}

fun containsSequence(pwd: String): Boolean {
    var i = 0
    while (i < pwd.length - 2)
    {
        val current = pwd[i]
        val secondChar = current + 1
        val thirdChar = current + 2

        if (secondChar == pwd[i + 1] && thirdChar == pwd[i + 2])
            return true
        
        i++
    }

    return false
}

fun containsTwoPairs(pwd: String): Boolean {
    val pairs = getPairs(pwd).distinct()
    return pairs.size >= 2
}

fun getPairs(pwd: String): List<String> {
    var i = 0
    var pairs = listOf<String>()
    while (i < pwd.length - 1)
    {
        val current = pwd[i]
        val next = pwd[i + 1]
        if (current == next)
        {
            pairs += "$current$next"
            i++
        }
        i++
    }
    return pairs
}