lenVec3 x y z = sqrt (x ^ 2 + y ^ 2 + z ^ 2)

sign x = if x > 0 then 1 else (if x < 0 then (-1) else 0)

-- {infixl 6 |-|}
x |-| y = abs(x - y)

logBase 4 $ min 20 $ 9 + 7 -- logBase 4 (min 20 (9 + 7))

import Data.Char
twoDigits2Int :: Char -> Char -> Int
twoDigits2Int x y = if isDigit(x) && isDigit(y) then 10 * digitToInt(x) + digitToInt(y) else 100

dist :: (Double, Double) -> (Double, Double) -> Double
dist p1 p2 = sqrt ((fst p1 - fst p2) ^ 2 + (snd p1 - snd p2) ^ 2)
