import java.util.*;

public class Circuit
{
    private final String input;
    private Map<String, Wire> wires;

    public Circuit(String input)
    {
        this.input = input;
    }

    public short RunOne(String key)
    {
        this.wires = GetWires(this.input);
        return this.wires.get(key).Signal();
    }

    public short RunTwo(String readKey, String writeKey)
    {
        var result1 = RunOne(readKey);
        this.wires = GetWires(this.input);
        this.wires.get(writeKey).SetSignal(result1);
        return this.wires.get(readKey).Signal();
    }

    private Map<String, Wire> GetWires(String input)
    {
        var strings = input.split("\n");
        var wires = new HashMap<String, Wire>();
        for (String s: strings)
        {
            var commandAndName = s.split("->");
            var commandAndValues = commandAndName[0].trim().split(" ");
            var name = commandAndName[1].trim();

            if (commandAndValues.length == 1)
            {
                var a = commandAndValues[0].trim();
                wires.put(name, new PassWire(wires, a));
            }

            else if (commandAndValues.length == 2)
            {
                var source = commandAndValues[1].trim();
                wires.put(name, new NotWire(wires, source));
            }

            else if (commandAndValues.length == 3)
            {
                var a = commandAndValues[0].trim();
                var command = commandAndValues[1].trim();
                var b = commandAndValues[2].trim();

                if (command == "AND")
                {
                    wires.put(name, new AndWire(wires, a, b));
                }

                else if (command == "OR")
                {
                    wires.put(name, new OrWire(wires, a, b));
                }

                else if (command == "LSHIFT")
                {
                    wires.put(name, new LeftShiftWire(wires, a, Short.parseShort(b)));
                }

                else if (command == "RSHIFT")
                {
                    wires.put(name, new RightShiftWire(wires, a, Short.parseShort(b)));
                }
            }
        }

        return wires;
    }
}