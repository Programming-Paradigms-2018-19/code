package basic

import kotlinx.coroutines.CoroutineStart
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.async
import kotlin.system.measureTimeMillis

suspend fun main(){
    val time = measureTimeMillis {
        val one = GlobalScope.async(start = CoroutineStart.LAZY) { doSomethingUsefulOne() }
        val two = GlobalScope.async(start = CoroutineStart.LAZY) { doSomethingUsefulTwo() }
        // some computation
        one.start() // start the first one
        two.start() // start the second one
        println("The answer is ${one.await() + two.await()}")
    }
    println("Completed in $time ms")
}