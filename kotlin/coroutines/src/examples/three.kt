package examples

import kotlinx.coroutines.runBlocking

//runBlocking is a coroutine function. By not providing any context, it will get run on the mainThread.
//Hence the result as running Thread.run(). Essentially the code is run in synchronous in a sequential manner.
//(i.e. code run per the order of the line).

fun main() {
    runBlocking {
        println("-Blocking- start : ")
        Thread.sleep(1000)
        println("-Blocking- ended : ")
    }

    run {
        println("-Run------ start : ")
        Thread.sleep(200)
        println("-Run------ ended : ")
    }
}