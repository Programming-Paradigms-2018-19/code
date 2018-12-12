package basic

import kotlinx.coroutines.delay
import kotlinx.coroutines.withTimeout

suspend fun main() {
    withTimeout(1300L) {
        repeat(1000) { i ->
            println("I'm sleeping $i ...")
            delay(500L)
        }
    }
}