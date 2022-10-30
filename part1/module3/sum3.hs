module Sum3 where


-- GHCi> sum3 [1,2,3] [4,5] [6]
-- [11,7,3]
sum3 :: Num a => [a] -> [a] -> [a] -> [a]
sum3 (a : as) (b : bs) (c : cs) = (a + b + c) : sum3 as bs cs
sum3 (a : as) (b : bs) _        = (a + b) : sum3 as bs []
sum3 (a : as) _        (c : cs) = (a + c) : sum3 as [] cs
sum3 _        (b : bs) (c : cs) = (b + c) : sum3 [] bs cs
sum3 (a : as) _        _        = a : sum3 as [] []
sum3 _        (b : bs) _        = b : sum3 [] bs []
sum3 _        _        (c : cs) = c : sum3 [] [] cs
sum3 []       []       []       = []

-- sum3 as bs cs = sum3acc as bs cs []
  
  -- where
    -- reversed solution
    -- sum3acc :: Num a => [a] -> [a] -> [a] -> [a] -> [a]
    -- sum3acc (a : as) (b : bs) (c : cs) acc = sum3acc as bs cs ((a + b + c) : acc)
    -- sum3acc (a : as) (b : bs) _        acc = sum3acc as bs [] ((a + b) : acc)
    -- sum3acc (a : as) _        (c : cs) acc = sum3acc as [] cs ((a + c) : acc)
    -- sum3acc _        (b : bs) (c : cs) acc = sum3acc [] bs cs ((b + c) : acc)
    -- sum3acc (a : as) _        _        acc = sum3acc as [] [] (a : acc)
    -- sum3acc _        (b : bs) _        acc = sum3acc [] bs [] (b : acc)
    -- sum3acc _        _        (c : cs) acc = sum3acc [] [] cs (c : acc)
    -- sum3acc []       []       []       acc = acc
