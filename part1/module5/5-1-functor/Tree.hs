module Demo where


import Data.Functor

data Tree a = Leaf (Maybe a) | Branch (Tree a) (Maybe a) (Tree a) deriving (Show, Eq)

instance Functor Tree where
  fmap f (Leaf x) = Leaf (fmap f x)
  fmap f (Branch l x r) = Branch (fmap f l) (fmap f x) (fmap f r)

test1 = words <$> Leaf Nothing
test2 = words <$> Leaf (Just "a b")

check = (test1 == Leaf Nothing) && (test2 == Leaf (Just ["a","b"]))
