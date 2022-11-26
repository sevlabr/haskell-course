module Demo where


data Tree a = Leaf a | Node (Tree a) (Tree a)

height :: Tree a -> Int
height t = height' t 0
  where
    height' :: Tree a -> Int -> Int
    height' (Leaf x)   acc = acc
    height' (Node x y) acc = max (height' x (acc + 1)) (height' y (acc + 1))

size :: Tree a -> Int
size t = size' t 0
  where
    size' :: Tree a -> Int -> Int
    size' (Leaf x)   acc = acc + 1
    size' (Node x y) acc = 1 + size' x acc + size' y acc

avg :: Tree Int -> Int
avg t =
    let (c,s) = go t
    in s `div` c
  where
    go :: Tree Int -> (Int,Int)
    go t = go' t (0,0)
      where
        go' :: Tree Int -> (Int,Int) -> (Int,Int)
        go' (Leaf x)   (c,s) = (c+1,s+x)
        go' (Node x y) (c,s) =
          let
            (lc,ls) = go' x (c,s)
            (rc,rs) = go' y (c,s)
            c' = lc + rc
            s' = ls + rs
          in
            (c',s')

----- TESTS -----
test1 = height (Leaf 1)
test2 = height (Node (Leaf 1) (Leaf 1))
test3 = height (Node (Node (Leaf 1) (Leaf 1)) (Leaf 1))
test4 = height (Node (Node (Leaf 1) (Leaf 1)) (Node (Leaf 1) (Leaf 1)))
test5 = height (Node (Node (Node (Leaf 1) (Leaf 1)) (Leaf 1)) (Node (Leaf 1) (Leaf 1)))
test6 = height (Node (Node (Node (Leaf 1) (Leaf 1)) (Node (Leaf 1) (Leaf 1))) (Node (Leaf 1) (Leaf 1)))
test7 = height (Node (Node (Node (Leaf 1) (Leaf 1)) (Node (Leaf 1) (Leaf 1))) (Node (Node (Leaf 1) (Leaf 1)) (Leaf 1)))
test8 = height (Node (Node (Node (Leaf 1) (Leaf 1)) (Node (Leaf 1) (Leaf 1))) (Node (Node (Leaf 1) (Leaf 1)) (Node (Leaf 1) (Leaf 1))))
test9 = height (Node (Node (Node (Node (Leaf 1) (Leaf 1)) (Leaf 1)) (Node (Leaf 1) (Leaf 1))) (Node (Node (Leaf 1) (Leaf 1)) (Node (Leaf 1) (Leaf 1))))

testsHeight = [test1, test2, test3, test4, test5, test6, test7, test8, test9]
testsHeightBool = testsHeight == [0,1,2,2,3,3,3,3,4]


test11 = size (Leaf 1)
test12 = size (Node (Leaf 1) (Leaf 1))
test13 = size (Node (Node (Leaf 1) (Leaf 1)) (Leaf 1))
test14 = size (Node (Node (Leaf 1) (Leaf 1)) (Node (Leaf 1) (Leaf 1)))

testsSize = [test11, test12, test13, test14]
testsSizeBool = testsSize == [1,3,5,7]


test21 = avg (Leaf 1)
test22 = avg (Node (Leaf 1) (Leaf 1))
test23 = avg (Node (Node (Leaf 1) (Leaf 1)) (Leaf 1))
test24 = avg (Node (Node (Leaf 1) (Leaf 1)) (Node (Leaf 1) (Leaf 1)))
test25 = avg (Node (Node (Node (Leaf 1) (Leaf 1)) (Leaf 1)) (Node (Leaf 1) (Leaf 1)))
test26 = avg (Node (Node (Node (Leaf 1) (Leaf 1)) (Node (Leaf 1) (Leaf 1))) (Node (Leaf 1) (Leaf 1)))
test27 = avg (Node (Node (Node (Leaf 1) (Leaf 1)) (Node (Leaf 1) (Leaf 1))) (Node (Node (Leaf 1) (Leaf 1)) (Leaf 1)))
test28 = avg (Node (Node (Node (Leaf 1) (Leaf 1)) (Node (Leaf 1) (Leaf 1))) (Node (Node (Leaf 1) (Leaf 1)) (Node (Leaf 1) (Leaf 1))))
test29 = avg (Node (Node (Node (Node (Leaf 1) (Leaf 1)) (Leaf 1)) (Node (Leaf 1) (Leaf 1))) (Node (Node (Leaf 1) (Leaf 1)) (Node (Leaf 1) (Leaf 1))))
test30 = avg (Node (Node (Node (Node (Leaf 7) (Leaf 8)) (Leaf 1)) (Node (Leaf 0) (Leaf (-1)))) (Node (Node (Leaf 11) (Leaf 2)) (Node (Leaf (-3)) (Leaf (-1)))))

testsAvg = [test21, test22, test23, test24, test25, test26, test27, test28, test29, test30]
testsAvgBool = testsAvg == [1,1,1,1,1,1,1,1,1,2]


testsBool = testsHeightBool && testsSizeBool && testsAvgBool
