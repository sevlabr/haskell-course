module Demo where


import Prelude hiding (lookup)

class MapLike m where
    empty :: m k v
    lookup :: Ord k => k -> m k v -> Maybe v
    insert :: Ord k => k -> v -> m k v -> m k v
    delete :: Ord k => k -> m k v -> m k v
    fromList :: Ord k => [(k,v)] -> m k v

newtype ArrowMap k v = ArrowMap { getArrowMap :: k -> Maybe v }

instance MapLike ArrowMap where
  empty = ArrowMap (\x -> Nothing)
  lookup key     (ArrowMap am) = am key
  insert key val (ArrowMap am) = ArrowMap (\x -> if x == key then Just val else am x)
  delete key     (ArrowMap am) = ArrowMap (\x -> if x == key then Nothing  else am x)
  
  fromList [] = empty
  fromList ((k,v):kvs) = insert k v (fromList kvs)
  -- fromList = foldr (uncurry insert) empty

--- Tests ---
testf :: Int -> Maybe Int
testf k =
  if k == 1 then Just 1 else
    if k == 2 then Just 2 else Nothing

testAm = ArrowMap testf

lookupExisting = lookup 1 testAm
lookupNothing  = lookup 3 testAm

insertNew      = lookup 3 (insert 3 3    testAm)
insertExisting = lookup 1 (insert 1 (-1) testAm)

deleteExisting = lookup 2 (delete 2 testAm)
deleteNothing  = lookup 4 (delete 4 testAm)

testFromListEmpty = fromList [] :: ArrowMap String Int
testFromList      = fromList [("a", 1), ("b", 2)] :: ArrowMap String Int

lookupFromList = lookup "a" testFromList
