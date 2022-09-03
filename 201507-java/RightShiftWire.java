import java.util.*;

public class RightShiftWire extends Wire
{
    private final Map<String, Wire> dictionary;
    private final String a;
    private final short distance;

    private char WireASignal(){
        return this.dictionary.get(this.a).Signal();
    }
        
    public char Signal()
    {
        if (this.signal == Character.MIN_VALUE)
            this.signal = (char)(WireASignal() >> this.distance);
        return this.signal;
    }

    public RightShiftWire(Map<String, Wire> dictionary, String a, short distance)
    {
        this.dictionary = dictionary;
        this.a = a;
        this.distance = distance;
    }
}