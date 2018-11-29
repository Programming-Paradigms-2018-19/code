def factorial(n: Int): Int = n match { 
    case 0 => 1
    case x if x > 0 => factorial(n - 1) * n 
}

object FactorialMain extends App {
  println(factorial(3))
  println(factorial(0))
}