module QSort where


-- GHCi> qsort [1,3,2,5]
-- [1,2,3,5]

-- This might be quite inefficient
-- (double 'filter' application and merging)
qsort :: Ord a => [a] -> [a]
qsort []       = []
qsort (x : xs) =
  let
    left  = filter (<  x) xs
    right = filter (>= x) xs
  in
    merge (qsort left) (x : qsort right)
  
  where
    merge :: Ord a => [a] -> [a] -> [a]
    merge []  ys' = ys'
    merge xs' []  = xs'
    merge (x : xs) ys' = x : merge xs ys'

-- Older solution:
-- merge :: Ord a => [a] -> [a] -> [a]
-- merge [] []  = []
-- merge [] ys' = ys'
-- merge xs' [] = xs'
-- merge (x : xs) ys' = x : merge xs ys'

-- qsort :: Ord a => [a] -> [a]
-- qsort []     = []
-- qsort (x : []) = [x]
-- qsort lst = merge (qsort $ filter (< head lst) lst) (merge (filter (== head lst) lst) (qsort $ filter (> head lst) lst))
