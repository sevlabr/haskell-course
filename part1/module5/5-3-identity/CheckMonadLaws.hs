module Demo where


data Log a = Log [String] a deriving (Eq, Show)

returnLog :: a -> Log a
returnLog = Log []

bindLog :: Log a -> (a -> Log b) -> Log b
bindLog (Log l1 x) f = let (Log l2 y) = f x
                        in Log (l1 ++ l2) y

-- GHC 7.6 -> 8.0
instance Functor Log where
  fmap = undefined

instance Applicative Log where
  pure = undefined
  (<*>) = undefined

instance Monad Log where
  return = returnLog
  (>>=) = bindLog

checkLaws :: (Monad m, Eq (m z), Eq (m x), Eq (m y)) => (x -> m y) -> (y -> m z) -> x -> m x -> [Bool]
checkLaws f g a m =
  [ (return a >>= f) == f a                        -- return a >>= k === k a
  , (m >>= return)   == m                          -- m >>= return   === m
  , (m >>= f >>= g)  == (m >>= (\x -> f x >>= g))] -- m >>= k >>= k' === m >>= (\x -> k x >>= k')
  
