module SeqA where

seqA :: Integer -> Integer
seqA n 
  | n >= 0 = let
      exprA 0 a0 a1 a2 = a0
      exprA 1 a0 a1 a2 = a1
      exprA 2 a0 a1 a2 = a2
      exprA n a0 a1 a2 = exprA (n - 1) a1 a2 (a2 + a1 - 2 * a0)
    in exprA n 1 2 3
  | otherwise = undefined
