module Demo where


data Triple a = Tr a a a
  deriving (Eq,Show)

instance Functor Triple where
  fmap f (Tr x y z) = Tr (f x) (f y) (f z)

instance Applicative Triple where
  pure v = Tr v v v
  (Tr f g h) <*> (Tr x y z) = Tr (f x) (g y) (h z)

testTripleFunctor = ((^2) <$> Tr 1 (-2) 3) == (Tr 1 4 9)
testTripleApplicative = (Tr (^2) (+2) (*3) <*> Tr 2 3 4) == (Tr 4 5 12)

testTriple = all (== True) [testTripleFunctor, testTripleApplicative]
