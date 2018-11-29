flatten :: [[a]] -> [a]
flatten [[]] = []
flatten ([]:ys) = flatten ys
flatten ((x:xs):ys) = x : (flatten (xs:ys))
