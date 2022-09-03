public abstract class Wire
{
    protected Short signal;

    public abstract Short Signal();

    public void SetSignal(Short signal)
    {
        this.signal = signal;
    }
}