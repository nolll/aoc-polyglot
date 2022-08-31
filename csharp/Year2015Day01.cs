namespace Aoc;

public static class Year2015Day01
{
    public static void Run()
    {
        var input = ReadInput();
        Run(input);
    }

    public static void Run(string s)
    {
        var floor = 0;
        var firstTimeInBasement = 0;
        var moves = 0;
        var chars = s.ToCharArray();

        foreach (var c in chars)
        {
            moves += 1;
            if (c == '(')
            {
                floor += 1;
            }
            else
            {
                floor -= 1;
                if (firstTimeInBasement == 0 && floor < 0)
                {
                    firstTimeInBasement = moves;
                }
            }
        }

        Console.WriteLine(floor);
        Console.WriteLine(firstTimeInBasement);
    }

    private static string ReadInput()
    {
        return System.IO.File.ReadAllText("../input/2015-01.txt");
    }
}