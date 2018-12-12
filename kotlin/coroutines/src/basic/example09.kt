package basic

fun main() {
    repeat(100_000) {
        Thread {
            println("+")
        }.run()

    }
}