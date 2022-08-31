namespace Aoc
{
    public class Program
    {
        static void Main(string[] args)
        {
            var year = args[0];
            var day = args[1];

            var input = ReadInput(year, day);

            Run(year, day, input);
        }

        static void Run(string year, string day, string input)
        {
            if (year == "2015")
            {
                if (day == "1")
                    Year2015Day01.Run(input);
                else if (day == "2")
                    Year2015Day02.Run(input);
                else
                    Console.WriteLine($"Day {day} {year} not found");
            }
            else
            {
                Console.WriteLine($"Year {year} not found");
            }
        }

        private static string ReadInput(string year, string day)
        {
            var d = day.Length == 1 ? $"0{day}" : day;
            try
            {
                return System.IO.File.ReadAllText($"../input/{year}-{d}.txt");
            }
            catch
            {
                return "";
            }
        }
    }
}
