module Demo where


import Prelude hiding (lookup)
import qualified Data.List as L
import qualified Data.Maybe as DM

class MapLike m where
  empty :: m k v
  lookup :: Ord k => k -> m k v -> Maybe v
  insert :: Ord k => k -> v -> m k v -> m k v
  delete :: Ord k => k -> m k v -> m k v
  fromList :: Ord k => [(k,v)] -> m k v
  fromList [] = empty
  fromList ((k,v):xs) = insert k v (fromList xs)

newtype ListMap k v = ListMap { getListMap :: [(k,v)] }
  deriving (Eq,Show)

instance MapLike ListMap where
  empty = ListMap []

  lookup key (ListMap lmap) | DM.isNothing maybeKv = Nothing
                            | otherwise            = Just $ snd $ DM.fromJust maybeKv
    where
      maybeKv = L.find (\kv -> fst kv == key) lmap
  
  insert key val (ListMap lmap) | DM.isNothing maybeIdx = ListMap ((key,val):lmap)
                                | otherwise             = ListMap lmap'
    where
      maybeIdx           = L.findIndex (\kv -> fst kv == key) lmap
      kvIdx              = DM.fromJust maybeIdx
      (l,rHead:rTail)    = L.splitAt kvIdx lmap
      lmap'              = l ++ (key,val):rTail

  delete key (ListMap lmap) = ListMap $ L.filter (\kv -> fst kv /= key) lmap

--- Some tests ---
emp = fromList [] :: ListMap String Int
test = fromList [("a", 1), ("b", 2), ("cd", (-1)), ("e", 100)] :: ListMap String Int

testLookupNothing = lookup "f" test
testLookupSuccess = lookup "b" test

testInsertNew = insert "g" 5 test
testInsertExisting = insert "b" 10 test

testDeleteNothing = delete "h" test
testDeleteExisting = delete "cd" test
