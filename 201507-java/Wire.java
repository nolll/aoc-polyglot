public abstract class Wire
{
    protected char signal = Character.MIN_VALUE;

    public abstract char Signal();

    public void SetSignal(char signal)
    {
        this.signal = signal;
    }
}