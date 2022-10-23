module SumNCount where

sum'n'count :: Integer -> (Integer, Integer)
sum'n'count x | x == 0    = (0, 1)
              | otherwise = s'n'c (abs x) 0 0
  
  where
    s'n'c :: Integer -> Integer -> Integer -> (Integer, Integer)
    s'n'c num s c | div num 10 == 0 = (s + mod num 10, c + 1)
                  | otherwise       = s'n'c (div num 10) (s + mod num 10) (c + 1)
