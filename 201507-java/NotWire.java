import java.util.*;

public class NotWire extends Wire
{
    private final Map<String, Wire> dictionary;
    private final String a;

    private char WireASignal(){
        return this.dictionary.get(this.a).Signal();
    }
        
    public char Signal()
    {
        if (this.signal == Character.MIN_VALUE)
            this.signal = (char)~WireASignal();
        return this.signal;
    }

    public NotWire(Map<String, Wire> dictionary, String a)
    {
        this.dictionary = dictionary;
        this.a = a;
    }
}