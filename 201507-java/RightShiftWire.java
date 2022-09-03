import java.util.*;

public class RightShiftWire extends Wire
{
    private final Map<String, Wire> dictionary;
    private final String a;
    private final short distance;

    private short WireASignal(){
        return this.dictionary.get(this.a).Signal();
    }
        
    public Short Signal()
    {
        if (this.signal == null)
            this.signal = (short)(WireASignal() >> this.distance);
        return this.signal;
    }

    public RightShiftWire(Map<String, Wire> dictionary, String a, short distance)
    {
        this.dictionary = dictionary;
        this.a = a;
        this.distance = distance;
    }
}