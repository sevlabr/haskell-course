module Demo where


import Prelude hiding (lookup)
import qualified Data.List as L

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

