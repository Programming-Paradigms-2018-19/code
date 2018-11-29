flatten :: [[a]] -> [a]
flatten [] = []
flatten (y:ys) = y ++ (flatten ys)
