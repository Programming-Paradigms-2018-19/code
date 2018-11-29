def functionWithAFunctionArgument(x : Int, y : Int, f : (Int, Int) => Int) = f(x,y)

functionWithAFunctionArgument(3, 5, {(x, y) => x + y})
