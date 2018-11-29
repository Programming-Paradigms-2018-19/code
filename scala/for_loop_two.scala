object FunctionalForLoop extends App {

def functionalForLoop {
    println( "for loop using functional style iteration" )
    args.foreach { arg =>
        println(arg)
    }
}

functionalForLoop

}