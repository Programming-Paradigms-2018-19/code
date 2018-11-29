def memo[X, Y](f: X => Y): X => Y = {
  val cache = collection.mutable.Map[X, Y]()
  (x: X) => {
    (cache get x) match {
      case Some(y) => y
      case None =>
        val y = f(x)
        cache(x) = y
        print("Stored ")
        println(y)
        y
    }
  }
}

val len = memo{
  xs: List[Int] =>
    xs.length
}

val l = List(1,2,3,4,5)
len(l)

len(l)
