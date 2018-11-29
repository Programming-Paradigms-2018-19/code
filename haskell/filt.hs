isEven :: Int -> Bool
isEven i = i `mod` 2 == 0


filt :: Int -> [Int] -> [Int]
filt x lst = [ if isEven i then x else i | i <- lst]

filt :: Int -> (Int -> Bool) ->[Int] -> [Int]
filtel x f lst = [ if f i then x else elem | (i, elem) <- zip [0..] lst]

-- filt 10 [1, 2, 3, 4, 4, 5] -> [1, 10, 3, 10, 10, 5]
-- filtel 10 [1, 2, 3, 4, 4, 5] -> [10, 2, 10, 4, 10, 5]