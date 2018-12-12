package basic

import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking


fun main() = runBlocking {
    repeat(100_000) {
        // launch a lot of coroutines
        launch {
            delay(1000L)
            println(".")
        }
    }
}