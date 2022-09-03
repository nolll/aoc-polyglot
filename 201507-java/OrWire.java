import java.util.*;

public class OrWire extends Wire
{
    private final Map<String, Wire> dictionary;
    private final String a;
    private final String b;

    private Short WireASignal(){
        try{
            short n = Short.parseShort(this.a);
            return n;
        }
        catch(NumberFormatException e)
        {
            return this.dictionary.get(this.a).Signal();
        }
    }

    private Short WireBSignal(){
        try{
            short n = Short.parseShort(this.b);
            return n;
        }
        catch(NumberFormatException e)
        {
            return this.dictionary.get(this.b).Signal();
        }
    }

    public Short Signal()
    {
        if (this.signal == null)
            this.signal = (short)(WireASignal() | WireBSignal());
        return this.signal;
    }

    public OrWire(Map<String, Wire> dictionary, String a, String b)
    {
        this.dictionary = dictionary;
        this.a = a;
        this.b = b;
    }
}