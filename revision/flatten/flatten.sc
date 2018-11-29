def flatten(l: List[_]): List[Any] = l match {
  case Nil => Nil
  case (head: List[_]) :: tail => flatten(head) ::: flatten(tail)
  case head :: tail => head :: flatten(tail)
}

val x = List(List(1), 2, List(List(3, 4), 5), List(List(List())), List(List(List(6))), 7, 8, List())

flatten(x)
