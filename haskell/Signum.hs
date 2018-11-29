module Signum (
sign
) where

sign :: Float -> Integer 
sign x
    | x > 0.0 = 1
    | x < 0.0 = -1
    | otherwise = 0