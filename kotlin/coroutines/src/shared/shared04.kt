package shared

import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.newSingleThreadContext
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.withContext

fun main() = runBlocking<Unit> {

    val counterContext = newSingleThreadContext("CounterContext")
    var counter = 0

    //sampleStart
    GlobalScope.massiveRun {
        // run each coroutine with DefaultDispathcer
        withContext(counterContext) {
            // but confine each increment to the single-threaded context
            counter++
        }
    }
    println("Counter = $counter")
//sampleEnd
}