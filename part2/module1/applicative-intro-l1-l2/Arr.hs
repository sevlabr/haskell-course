module Demo where


newtype Arr2 e1 e2 a = Arr2 { getArr2 :: e1 -> e2 -> a }
newtype Arr3 e1 e2 e3 a = Arr3 { getArr3 :: e1 -> e2 -> e3 -> a }

instance Functor (Arr2 e1 e2) where
  fmap f (Arr2 g) = Arr2 $ \x y -> f $ g x y

instance Functor (Arr3 e1 e2 e3) where
  fmap f (Arr3 g) = Arr3 $ \x y z -> f $ g x y z

testGetArr2 = getArr2 (fmap length (Arr2 take)) 10 "abc" == 3
testGetArr3 = getArr3 (tail <$> tail <$> Arr3 zipWith) (+) [1,2,3,4] [10,20,30,40,50] == [33,44]

testGetArr = all (== True) [testGetArr2, testGetArr3]
