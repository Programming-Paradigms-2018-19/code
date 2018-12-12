package shared

import kotlinx.coroutines.GlobalScope
import java.util.concurrent.atomic.AtomicInteger


suspend fun main(){
    var counter = AtomicInteger()

    GlobalScope.massiveRun {
        counter.incrementAndGet()
    }
    println("Counter = ${counter.get()}")
}