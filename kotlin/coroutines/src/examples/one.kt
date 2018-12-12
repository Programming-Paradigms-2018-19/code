package examples


//Calling Thread.run() for a Thread isn’t do anything other than like a normal run on the same thread
//(i.e. main thread in this case). The code get run synchronously in a sequential manner.
//(i.e. code run per the order of the line)

fun main() {
    Thread {
        println("-Thread--- start : ")
        Thread.sleep(1000)
        println("-Thread--- ended : ")
    }.run()


    run {
        println("-Run------ start : ")
        Thread.sleep(200)
        println("-Run------ ended : ")
    }
}