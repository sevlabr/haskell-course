{-
(1): fmap id cont = cont; fmap id = id
(2): fmap f (fmap g cont) = fmap (f . g) cont; fmap f . fmap g = fmap (f . g)
-}

{-
instance Functor ((->) e) where
  fmap :: (a -> b) -> (e -> a) -> (e -> b)
  fmap = (.)
-}

-- id :: a -> a
-- f :: e -> a
-- (const :: a -> e -> a, const a :: e -> a)

{-
(1):
fmap id f
  == id . f
  == f
-}

{-
(2):
fmap f (fmap g h)
  == fmap f (g . h)
  == f . g . h
fmap (f . g) h
  == (f . g) . h
  == f . g . h
-}

-- '+' означает, что использовалось, а '-' означает, что не использовалось
-- Левый нейтральный элемент для композиции (+)
-- Правый нейтральный элемент для композиции (-)
-- Композиция ассоциативна (+)
-- Композиция не коммутативна (-)
