module Demo where


data Tree a = Leaf a | Node (Tree a) (Tree a)

height :: Tree a -> Int
height = undefined

size :: Tree a -> Int
size = undefined
