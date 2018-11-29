def sum_of_squares(xs: Seq[Double]) = xs.foldLeft(0.0)(_ + Math.pow(_, 2))

def sum_of_squares_map(xs: Seq[Double]) = xs.map(Math.pow(_, 2)).sum

sum_of_squares(List(1,2,3))

sum_of_squares_map(List(1,2,3))

