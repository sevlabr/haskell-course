module Simple where


import Data.Char


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
