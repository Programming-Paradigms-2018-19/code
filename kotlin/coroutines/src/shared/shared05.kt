package shared

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.newSingleThreadContext
import kotlinx.coroutines.runBlocking


fun main() = runBlocking<Unit> {
    val counterContext = newSingleThreadContext("CounterContext")
    var counter = 0

    //sampleStart
    CoroutineScope(counterContext).massiveRun { // run each coroutine in the single-threaded context
        counter++
    }
    println("Counter = $counter")
//sampleEnd
}