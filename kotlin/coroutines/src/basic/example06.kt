package basic

import kotlinx.coroutines.*

fun main() = runBlocking {
    // this: CoroutineScope
    launch {
        delay(100L)
        println("Task from runBlocking")
    }

    coroutineScope {
        // Creates a new coroutine scope
        launch {
            delay(100L)
            println("Task from nested launch")
        }

        delay(100L)
        println("Task from coroutine scope") // This line will be printed before nested launch
    }

    println("Coroutine scope is over") // This line is not printed until nested launch completes
}