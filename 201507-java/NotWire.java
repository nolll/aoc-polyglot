import java.util.*;

public class NotWire extends Wire
{
    private final Map<String, Wire> dictionary;
    private final String a;

    private short WireASignal(){
        return this.dictionary.get(this.a).Signal();
    }
        
    public Short Signal()
    {
        if (this.signal == null)
            this.signal = (short)~WireASignal();
        return this.signal;
    }

    public NotWire(Map<String, Wire> dictionary, String a)
    {
        this.dictionary = dictionary;
        this.a = a;
    }
}