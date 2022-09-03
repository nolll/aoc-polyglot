import java.util.*;

public class PassWire extends Wire
{
    private final Map<String, Wire> dictionary;
    private final String a;

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

    public char Signal()
    {
        if (this.signal == Character.MIN_VALUE)
            this.signal = WireASignal();
        return this.signal;
    }

    public PassWire(Map<String, Wire> dictionary, String a)
    {
        this.dictionary = dictionary;
        this.a = a;
    }
}