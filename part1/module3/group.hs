module GroupElements where


-- GHCi> groupElems []
-- []
-- GHCi> groupElems [1,2]
-- [[1],[2]]
-- GHCi> groupElems [1,2,2,2,4]
-- [[1],[2,2,2],[4]]
-- GHCi> groupElems [1,2,3,2,4]
-- [[1],[2],[3],[2],[4]]
groupElems :: Eq a => [a] -> [[a]]
groupElems []       = []
groupElems (a : as) = 
  let
    spanRes = span (== a) (a : as)
  in
    fst spanRes : groupElems (snd spanRes)

groupElems' :: Eq a => [a] -> [[a]]
groupElems' []  = []
groupElems' [x] = [[x]]
groupElems' (x : xs)
  | x == head xs =
    let
      (r : rs) = groupElems' xs
    in
      (x : r) : rs
  | otherwise    =
    [x] : groupElems' xs
