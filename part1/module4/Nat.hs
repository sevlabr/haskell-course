module Nat where


data Nat = Zero | Suc Nat
  deriving Show

fromNat :: Nat -> Integer
fromNat Zero = 0
fromNat (Suc n) = fromNat n + 1

toNat :: Integer -> Nat
toNat 0 = Zero
toNat n = Suc $ toNat $ n - 1 

add :: Nat -> Nat -> Nat
add l r = toNat $ fromNat l + fromNat r

mul :: Nat -> Nat -> Nat
mul l r = toNat $ fromNat l * fromNat r

fac :: Nat -> Nat
fac Zero = Suc Zero
fac n'@(Suc n) = mul n' (fac n)
