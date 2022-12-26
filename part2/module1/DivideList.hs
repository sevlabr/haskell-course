module Demo where


divideList :: Fractional a => [a] -> a
divideList []     = 1
divideList (x:xs) = (/) x (divideList xs)

testDivideList = divideList [3,4,5] == 3.75

divideList' :: (Show a, Fractional a) => [a] -> (String, a)
divideList' []     = ("1.0", 1)
divideList' (x:xs) = (/) <$> ("<-" ++ show x ++ "/", x) <*> divideList' xs

testDivideList' = divideList' [3,4,5] == ("<-3.0/<-4.0/<-5.0/1.0", 3.75)
-- x / y * z / w * k / j * ...
