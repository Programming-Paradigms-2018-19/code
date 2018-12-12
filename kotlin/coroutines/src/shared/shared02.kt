package shared

import kotlinx.coroutines.*

@Volatile // in Kotlin `volatile` is an annotation
var counter = 0

fun main() = runBlocking<Unit> {
    GlobalScope.massiveRun {
        counter++
    }
    println("Counter = $counter")
}