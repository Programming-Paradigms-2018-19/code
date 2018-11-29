import java.util.concurrent.CountDownLatch;

public class Processes implements Runnable {
    private CountDownLatch latch;
    public Processes(CountDownLatch l) {
	latch = l;
    }
    public void run() {
	try { latch.await(); } catch (Exception e) { }
    }
	
    public static void main(String args[]) {
	int  N = 5000;
	CountDownLatch[] ls = new CountDownLatch[N];
        long start = System.currentTimeMillis();
	for (int i = 0; i<N; i++) {
	    ls[i] = new CountDownLatch(1);
	    new Thread(new Processes(ls[i])).start();
	}
	for (int i = 0; i<N; i++) {
	    ls[i].countDown();
	}
	long end = System.currentTimeMillis();
	double time = (end-start)*1000.0 / (N*1.0);
	System.out.println("Process spawn time = "+time);
    }
}