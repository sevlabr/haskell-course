module Demo where


newtype Xor = Xor { getXor :: Bool }
  deriving (Eq,Show)

instance Semigroup Xor where
  Xor False <> Xor False = Xor False
  Xor a     <> Xor b     = Xor (not $ a && b)
  -- Xor (x /= y) is XOR

instance Monoid Xor where
  mempty = Xor False


-- To use Monoids like in old versions:
-- instance Semigroup Xor where
--   a <> b = undefined

-- instance Monoid Xor where
--   mempty = undefined
--   mappend = (Data.Semigroup.<>)
