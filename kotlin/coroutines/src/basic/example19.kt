package basic

import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.async
import kotlin.system.measureTimeMillis

suspend fun main() {
    val time = measureTimeMillis {
        val one = GlobalScope.async { doSomethingUsefulOne() }
        val two = GlobalScope.async { doSomethingUsefulTwo() }
        println("The answer is ${one.await() + two.await()}")
    }
    println("Completed in $time ms")
}