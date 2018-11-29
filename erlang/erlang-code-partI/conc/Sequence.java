public class Sequence {
    private int nextval = 0;

    public synchronized int getNext() {
        return nextVal++;
    }

    public synchronized reset() {
        nextVal = 0;
    }
}