module Demo where


newtype Arr2 e1 e2 a = Arr2 { getArr2 :: e1 -> e2 -> a }
newtype Arr3 e1 e2 e3 a = Arr3 { getArr3 :: e1 -> e2 -> e3 -> a }

instance Functor (Arr2 e1 e2) where
  fmap f (Arr2 g) = Arr2 $ \x y -> f $ g x y

instance Functor (Arr3 e1 e2 e3) where
  fmap f (Arr3 g) = Arr3 $ \x y z -> f $ g x y z

instance Applicative (Arr2 e1 e2) where
  -- fmap = (<*>) . pure (т.к. fmap f x = pure f <*> x)
  -- (actually, it's useless here)
  -- One of possible variants: pure = Arr2 . pure . pure
  pure v = Arr2 $ \e1 e2 -> v
  (Arr2 f) <*> (Arr2 g) = Arr2 $ \e1 e2 -> f e1 e2 (g e1 e2)

instance Applicative (Arr3 e1 e2 e3) where
  pure v = Arr3 $ \e1 e2 e3 -> v
  (Arr3 f) <*> (Arr3 g) = Arr3 $ \e1 e2 e3 -> f e1 e2 e3 (g e1 e2 e3)

-- 2 + 3 - (2 * 3) = -1
testApplicativeGetArr2 = (getArr2 (Arr2 (\x y z -> x + y - z)       <*> Arr2 (*))                   2 3)   == (-1)
-- 2 + 3 + 4 - (2 * 3 * 4) = -15
testApplicativeGetArr3 = (getArr3 (Arr3 (\x y z w -> x + y + z - w) <*> Arr3 (\x y z -> x * y * z)) 2 3 4) == (-15)
