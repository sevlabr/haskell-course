module Demo where


import MyMonads

data Tree a = Leaf a | Fork (Tree a) a (Tree a)
  deriving (Show, Eq)

buildNumTree :: State (Integer, Tree ()) (Integer, Tree Integer)
buildNumTree = do
  (n, treeStructure) <- get
  case treeStructure of
    Leaf ()    -> do
      let n' = succ n
      return (n', Leaf n')
    Fork l m r -> do
      let (nl, l') = evalState buildNumTree (n, l)
      let m' = succ nl
      let (nr, r') = evalState buildNumTree (m', r)
      return (nr, Fork l' m' r')

numberTree :: Tree () -> Tree Integer
numberTree tree = snd $ evalState buildNumTree (0, tree)

testNumberTree1 = numberTree (Leaf ()) == Leaf 1
testNumberTree2 = numberTree (Fork (Leaf ()) () (Leaf ())) == Fork (Leaf 1) 2 (Leaf 3)

testsNumberTree = all (== True) [testNumberTree1, testNumberTree2]
