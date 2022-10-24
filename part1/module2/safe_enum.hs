module SafeEnumModule where


getMaxBound :: Bounded a => a -> a
getMaxBound _ = maxBound

getMinBound :: Bounded a => a -> a
getMinBound _ = minBound

class (Eq a, Enum a, Bounded a) => SafeEnumWithSuppFuncs a where
  ssucc :: a -> a
  ssucc inp = if inp == getMaxBound inp then getMinBound inp else succ inp

  spred :: a -> a
  spred inp = if inp == getMinBound inp then getMaxBound inp else pred inp


-- Another possible variant (without vars in min/maxBound):

class (Eq a, Enum a, Bounded a) => SafeEnum a where
  ssucc :: a -> a
  ssucc inp = if inp == maxBound then minBound else succ inp

  spred :: a -> a
  spred inp = if inp == minBound then maxBound else pred inp

-- instance SafeEnum Bool

-- GHCi> ssucc False
-- True
-- GHCi> ssucc True
-- False
