import java.util.*;

public class AndWire extends Wire
{
    private final Map<String, Wire> dictionary;
    private final String a;
    private final String b;

    private short WireASignal(){
        try{
            short n = Short.parseShort(this.a);
            return n;
        }
        catch(NumberFormatException e)
        {
            return this.dictionary.get(this.a).Signal();
        }
    }

    private short WireBSignal(){
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
        if(this.signal == null)
            this.signal = (short)(WireASignal() & WireBSignal());
        return this.signal;
    }

    public AndWire(Map<String, Wire> dictionary, String a, String b)
    {
        this.dictionary = dictionary;
        this.a = a;
        this.b = b;
    }
}