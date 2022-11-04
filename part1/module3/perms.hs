module Perms where


---- MORE BEAUTIFUL SOLUTION ----
-- the logic is like in your solution but this one is more compact
-- check this if you need an explanation: https://stepik.org/lesson/12321/step/8?discussion=337724&reply=342167&thread=solutions&unit=2785


perms' :: [a] -> [[a]]
perms' []     = [[]]
perms' (x:xs) = concatMap (insertElem x) (perms xs)
  
  where
    insertElem :: a -> [a] -> [[a]]
    insertElem x []         = [[x]]
    insertElem x yss@(y:ys) = (x:yss) : map (y:) (insertElem x ys)


---- MY SOLUTION ----
-- resources: - https://github.com/bapjiws/haskell-permutations/blob/master/Permutations.hs
--            - https://stepik.org/lesson/12321/step/8?discussion=650319&unit=2785
--            - also check notes and examples below;
--            - you actually thought in the right direction but didn't know how to implement it

-- *Perms> cyclicPerm [1,2,3,4]
-- [[1,2,3,4],[4,1,2,3],[3,4,1,2],[2,3,4,1]]

cyclicPerm :: [a] -> [[a]]
cyclicPerm lst = cyclicPerm' lst [] (length lst)
  
  where
    cyclicPerm' :: [a] -> [[a]] -> Int -> [[a]]
    cyclicPerm' (x : xs) acc n | n == 0    = acc
                               | otherwise =
                                  let
                                    rotated = xs ++ [x]
                                  in
                                    cyclicPerm' rotated (rotated : acc) (n - 1)

-- GHCi> perms [1,2,3]
-- [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]] -- the output is actually in the different order

-- [1,2,3], [3,1,2], [2,3,1] - one cyclic permutation
-- [1,3,2], [2,1,3], [3,2,1] - the other cyclic permutation

perms :: [a] -> [[a]]
perms []       = [[]]
perms (x : xs) = concatMap cyclicPerm (map (x:) (perms xs))
-- so you take the head and permute what's left, then concat it with the
-- taken head and perform cyclic permutation on the results

-- [1,2,3], [3,1,2], [2,3,1] - one cyclic permutation
-- [1,3,2], [2,1,3], [3,2,1] - the other cyclic permutation
-- note the transition permutation between in the 1st column

-- perms (x : xs) = concatMap cyclicPerm (map (x:) (cyclicPerm xs))
-- perms (x : xs) = concatMap cyclicPerm [[1,2,3], [2,1,3]] -- [[1,2,3], [1,3,2]]

--------- everything below doesn't work

-- permute (x : y) = y ++ [x] -- (\(x : xs) -> xs ++ [x])

-- perms :: [a] -> [[a]]
-- perms [] = [[]]
-- perms xs'@(x : xs) = xs' : map (head . perms) [xs ++ [x]]
-- perms xs'@(x : xs) = xs' : concatMap perms (map perms xs) -- bad

-- *Perms> perms [1]
-- [[1],[1]]
-- *Perms> perms [1,2]
-- [[1,2],[2,1]]
-- *Perms> perms [1,2,3]
-- [[1,2,3],[2,3,1]]
-- perms :: [a] -> [[a]]
-- perms [] = [[]]
-- perms xs'@(x : xs) = xs' : [(head (perms xs)) ++ [x]]

-- Wrong:
-- *Perms> perms [1,2]
-- [[2,1],[1,2],[1,2]]
-- *Perms> perms [1,2]
-- [[2,1],[2,1]]
-- *Perms> perms [1]
-- [[1]]
-- *Perms> perms [1,2,3]
-- [[2,3,1],[3,1,2],[1,2,3],[2,3,1],[3,1,2],[3,1,2]]
-- perms :: [a] -> [[a]]
-- perms [] = [[]]
-- perms lst = perms' lst (product [1..(length lst)])
  
--   where
--     perms' :: [a] -> Int -> [[a]]
--     perms' xs       1 = [xs] -- perms' xs       0 = [xs]
--     perms' (x : xs) n = (xs ++ [x]) : perms' (xs ++ [x]) (n - 1)
