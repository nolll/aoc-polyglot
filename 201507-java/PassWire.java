import java.util.*;

public class PassWire extends Wire
{
    private final Map<String, Wire> dictionary;
    private final String a;

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

    public Short Signal()
    {
        if (this.signal == null)
            this.signal = WireASignal();
        return this.signal;
    }

    public PassWire(Map<String, Wire> dictionary, String a)
    {
        this.dictionary = dictionary;
        this.a = a;
    }
}