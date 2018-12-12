package examples

import kotlinx.coroutines.*
import kotlin.concurrent.thread
import kotlin.system.measureTimeMillis

val TIME = 1000L
val SIZE = 100_000

fun functh() {
    val jobs = List(SIZE) {
        thread {
            Thread.sleep(TIME)
//            println("+")
        }
    }
    jobs.forEach { it.join() }
}

fun funcco() = runBlocking {
    val jobs = List(SIZE) {
        GlobalScope.launch {
            delay(TIME)
//            println(".")
        }
    }
    jobs.forEach { it.join() }
}

fun harness(f: () -> Unit){
    print("starting...")
    try {
        val time = measureTimeMillis {
            f()
        }
        println("Completed in $time ms")
    } catch (ex: Exception){
        println(ex)
    }
}

fun main() {
    harness(::funcco)
    harness(::functh)
}