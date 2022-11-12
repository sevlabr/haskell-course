module Simple where


import Data.Char
import Data.List


-- GHCi> addTwoElements 2 12 [85,0,6]
-- [2,12,85,0,6]
addTwoElements :: a -> a -> [a] -> [a]
addTwoElements val1 val2 lst = val1 : val2 : lst



-- GHCi> nTimes 42 3
-- [42,42,42]
-- GHCi> nTimes 'z' 5
-- "zzzzz"
nTimes :: a -> Int -> [a]
nTimes val n = insertToLst val n []
  
  where
    insertToLst :: a -> Int -> [a] -> [a]
    insertToLst val n lst | n == 0    = lst
                          | n >  0    = insertToLst val (n - 1) (val : lst)
                          | otherwise = undefined



-- slow, use Prelude.reverse instead
-- GHCi> myReverse [2,5,7,10,11,12]
-- [12,11,10,7,5,2]
-- myReverse :: [a] -> [a]
-- myReverse []  = []
-- myReverse (x : []) = [x]
-- myReverse (x : xs) = myReverse xs ++ [x]

-- GHCi> oddsOnly [2,5,7,10,11,12]
-- [5,7,11]
-- oddsOnly :: Integral a => [a] -> [a]
-- oddsOnly [] = []
-- oddsOnly lst = reverse $ outOddsOnly lst [] -- 'reverse $' is not needed in case of 'res ++ [x]' approach

--   where
--     outOddsOnly :: Integral a => [a] -> [a] -> [a]
    -- reversed order: [11,7,5]
    -- outOddsOnly (x : xs) res | xs == []  = if odd x then x : res else res
    --                          | otherwise = if odd x then outOddsOnly xs (x : res) else outOddsOnly xs res
    -- too slow
    -- outOddsOnly (x : xs) res | xs == []  = if odd x then res ++ [x] else res
    --                          | otherwise = if odd x then outOddsOnly xs (res ++ [x]) else outOddsOnly xs res

-- GHCi> oddsOnly [2,5,7,10,11,12]
-- [5,7,11]
oddsOnly :: Integral a => [a] -> [a]
oddsOnly [] = []
oddsOnly (x : xs) | odd x     = x : oddsOnly xs
                  | otherwise = oddsOnly xs



-- GHCi> readDigits "365ads"
-- ("365","ads")
-- GHCi> readDigits "365"
-- ("365","")

readDigits :: String -> (String, String)
readDigits lst = span isDigit lst



-- GHCi> filterDisj (< 10) odd [7,8,10,11,12]
-- [7,8,11]

filterDisj :: (a -> Bool) -> (a -> Bool) -> [a] -> [a]
filterDisj p1 p2 lst = filter (\x -> p1 x || p2 x) lst



-- GHCi> squares'n'cubes [3,4,5]
-- [9,27,16,64,25,125]

squares'n'cubes :: Num a => [a] -> [a]
squares'n'cubes lst = concatMap (\x -> [x^2, x^3]) lst
-- squares'n'cubes lst = concat [map (^2) lst, map (^3) lst] -- [9,16,25,27,64,125]



-- GHCi> delAllUpper "Abc IS not ABC"
-- "Abc not"

delAllUpper :: String -> String
delAllUpper = unwords . filter (not . all isUpper) . words



-- GHCi> max3 [7,2,9] [3,6,8] [1,8,10]
-- [7,8,10]
-- GHCi> max3 "AXZ" "YDW" "MLK"
-- "YXZ"

max3 :: Ord a => [a] -> [a] -> [a] -> [a]
max3 = zipWith3 (\x y z -> max x $ max y z)



-- GHCi> take 10 $ fibStream
-- [0,1,1,2,3,5,8,13,21,34]

fibStream :: [Integer]
fibStream = [0,1] ++ zipWith (+) fibStream (tail fibStream)
-- fibStream = [0,1] ++ [seq 1 (fibStream!!((length fibStream) - 1) + fibStream!!((length fibStream) - 2))] -- kinda shows the idea but doesn't work



-- Написать определение функции repeat через iterate

repeat' :: a -> [a]
repeat' = iterate repeatHelper
  
  where
    repeatHelper :: a -> a
    repeatHelper = id



-- concat using foldr
-- GHCi> concatList [[1,2],[],[3]]
-- [1,2,3]

concatList :: [[a]] -> [a]
concatList = foldr (++) []



-- GHCi> lengthList [7,6,5]
-- 3

lengthList :: [a] -> Int
lengthList = foldr (\_ s -> s + 1) 0



-- GHCi> sumOdd [2,5,30,37]
-- 42

sumOdd :: [Integer] -> Integer
sumOdd = foldr (\x s -> if x `mod` 2 == 1 then s + x else s) 0



-- GHCi> meanList [1,2,3,4]
-- 2.5

meanList :: [Double] -> Double
meanList = uncurry (/) . foldr (\x (s, l) -> (s + x, l + 1)) (0, 0)
-- meanList lst = (foldr (+) 0 lst) / (fromIntegral (length lst))



-- GHCi> evenOnly [1..10]
-- [2,4,6,8,10]
-- GHCi> evenOnly ['a'..'z']
-- "bdfhjlnprtvxz"

-- GHCi> take 3 (evenOnly [1..])
-- [2,4,6]

evenOnly :: [a] -> [a]
evenOnly = undefined

-- Works right on finite lists. But ineffective. Because of ++ [x] and (maybe) simple foldl
evenOnly' :: [a] -> [a]
evenOnly' = fst . foldl (\(l, c) x -> if even c then (l ++ [x], c + 1) else (l, c + 1)) ([], 1)
-- Doesn't work because the list indexing starts from tail
-- evenOnly'' = fst . foldr (\x (l, c) -> if even c then (x:l, c + 1) else (l, c + 1)) ([], 0)
-- Beautiful
-- evenOnly''' = snd . foldr (\x (xs, ys) -> (x:ys, xs)) ([], [])
-- evenOnly'''' = fst . foldl' (\(l, c) x -> if even c then (l ++ [x], c + 1) else (l, c + 1)) ([], 1)
