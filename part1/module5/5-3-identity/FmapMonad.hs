module Demo where


data SomeType a = SomeType { runSomeType :: a}  deriving (Show, Eq)

instance Monad SomeType where
  return x = SomeType x
  SomeType x >>= f = f x

instance Functor SomeType where
  fmap f x = x >>= (\val -> return $ f val)

instance Applicative SomeType where
  pure x = SomeType x
  SomeType f <*> SomeType v = SomeType (f v)

-- Silly tests (this one is kinda unfinished)
val = SomeType 2
func = (\x -> return $ x * x)
test = runSomeType $ val >>= func
