namespace Aoc;

public static class Year2015Day02
{
    public static void Run(string input)
    {
        var paper = 0;
        var ribbon = 0;
        var lines = input.Split("\n").Select(o => o.Trim());
        foreach (var line in lines)
        {
            var parts = line.Split('x');
            var w = int.Parse(parts[0]);
            var h = int.Parse(parts[1]);
            var d = int.Parse(parts[2]);
            paper += GetRequiredPaper(w, h, d);
            ribbon += GetRequiredRibbon(w, h, d);
        }
        Console.WriteLine(paper);
        Console.WriteLine(ribbon);
    }

    private static int GetRequiredPaper(int w, int h, int d)
    {
        var a = w * h;
        var b = h * d;
        var c = w * d;
        var areas = new List<int> { a, b, c };
        areas.Sort();
        var smallest = areas.First();
        return (a + b + c) * 2 + smallest;
    }

    private static int GetRequiredRibbon(int w, int h, int d)
    {
        var sides = new List<int> { w, h, d };
        sides.Sort();
        var bow = w * h * d;
        return (sides[0] + sides[1]) * 2 + bow;
    }
}