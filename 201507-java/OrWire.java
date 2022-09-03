import java.util.*;

public class OrWire extends Wire
{
    private final Map<String, Wire> dictionary;
    private final String a;
    private final String b;

    private char WireASignal(){
        try{
            char n = (char)Integer.parseInt(this.a);
            return n;
        }
        catch(NumberFormatException e)
        {
            return this.dictionary.get(this.a).Signal();
        }
    }

    private char WireBSignal(){
        try{
            char n = (char)Integer.parseInt(this.b);
            return n;
        }
        catch(NumberFormatException e)
        {
            return this.dictionary.get(this.b).Signal();
        }
    }

    public char Signal()
    {
        if (this.signal == Character.MIN_VALUE)
            this.signal = (char)(WireASignal() | WireBSignal());
        return this.signal;
    }

    public OrWire(Map<String, Wire> dictionary, String a, String b)
    {
        this.dictionary = dictionary;
        this.a = a;
        this.b = b;
    }
}