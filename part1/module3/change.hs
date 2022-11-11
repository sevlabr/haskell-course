module Change where


-- coins = [2, 3, 7]
-- GHCi> change 7
-- [[2,2,3],[2,3,2],[3,2,2],[7]]

-- Ideal solution
-- 1) Added 'map fromInteger' to overcome problems with the type of x
-- 2) Changed condition checking from 'x + (sum ys) == s' to 's < 0'
--    (the smarter way)
coins = [2, 3, 7]

change'' :: (Ord a, Num a) => a -> [[a]]
change'' s | s <  0    = []
           | s == 0    = [[]]
           | otherwise = [x:ys | x <- map fromInteger coins, ys <- change'' (s - x)]

-- Заглушка для компиляции change
coins' = []

-- Passed tests on Stepik. But if you define coins explicitly here, this throws an error.
-- It doesn't like 'x' in '(s - x)' because it is Integer but 'a' type is expected.
-- change :: (Ord a, Num a) => a -> [[a]]
change s | s <= 0    = [[]]
         | otherwise = [x:ys | x <- coins', ys <- change (s - x), x + (sum ys) == s]


-- Analogous version but with possibility to pass coins to the function.
change' :: (Ord a, Num a) => a -> [a] -> [[a]]
change' s coins | s <= 0    = [[]]
                | otherwise = [x:ys | x <- coins, ys <- change' (s - x) coins, x + (sum ys) == s]

-- Minimalistic version. Works only with [2, 3, 7] and gives [[2,2,3],[2,3,2],[3,2,2]]
-- [x:y:z:acc | x <- [2, 3, 7], y <- [2, 3, 7], z <- [2, 3, 7], acc <- [[]], x + y + z == 7]
