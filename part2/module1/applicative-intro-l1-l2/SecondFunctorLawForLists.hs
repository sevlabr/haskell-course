{-
Что доказываем: fmap f (fmap g xs) == fmap (f . g) xs,
                где xs - список некоторого типа a: [a],
                g :: (a -> b),
                f :: (b -> c)
Предполагается, что все списки конечны и не содержат расходимостей.

Реализация (для справки):
instance Functor [] where
  fmap :: (a -> b) -> [a] -> [b]
  fmap _ []     = []
  fmap f (x:xs) = f x : fmap f xs

Доказательство:
(1)   База индукции:
      Докажем, что верно для []:
        L) fmap f (fmap g [])  -- def fmap
              == fmap f []     -- def fmap
              == []
        R) fmap (f . g) []  -- def fmap
              == []
        L == R,
        следовательно, база индукции верна.
(2)   Индукционный переход:
(2.1) Гипотеза индукции (IH):
      Предположим, что для непустого списка xs выполняется:
      fmap f (fmap g xs) == fmap (f . g) xs
(2.2) Шаг индукции:
      Докажем для списка (x:xs):
        L) fmap f (fmap g (x:xs))            -- def fmap
            == fmap f (g x : fmap g xs)      -- def fmap
            == f (g x) : fmap f (fmap g xs)  -- IH
            == f (g x) : fmap (f . g) xs
        R) fmap (f . g) (x:xs)              -- def fmap
            == (f . g) x : fmap (f . g) xs  -- def (.)
            == f (g x) : fmap (f . g) xs
        L == R,
        следовательно, второй закон функторов выполняется для функтора списка,
        ч.т.д.
-}
