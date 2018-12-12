package examples

//Calling Thread.start() for a Thread is actuall starting a new thread,
//i.e. Thread-0 thread. The code get run asynchronously, as the two threads are run in parallel.

fun main() {
    Thread {
        println("-Thread--- start : ")
        Thread.sleep(1000)
        println("-Thread--- ended : ")
    }.start()

    run {
        println("-Run------ start : ")
        Thread.sleep(200)
        println("-Run------ ended : ")
    }
}