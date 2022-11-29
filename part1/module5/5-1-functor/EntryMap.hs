module Demo where


import Data.Char

data Entry k1 k2 v = Entry (k1, k2) v  deriving (Show, Eq)
data Map k1 k2 v = Map [Entry k1 k2 v]  deriving (Show, Eq)

instance Functor (Entry k1 k2) where
  fmap f (Entry (p1, p2) val) = Entry (p1, p2) (f val)

instance Functor (Map k1 k2) where
  fmap _ (Map []) = Map []
  fmap f (Map entries) = Map (map (fmap f) entries)

test1 = fmap (map toUpper) $ Map []
test2 = fmap (map toUpper) $ Map [Entry (0, 0) "origin", Entry (800, 0) "right corner"]

check = (test1 == (Map [] :: Map Int Int String)) && (test2 == Map [Entry (0,0) "ORIGIN",Entry (800,0) "RIGHT CORNER"])
