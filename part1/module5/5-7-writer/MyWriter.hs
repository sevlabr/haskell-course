module MyWriter where


newtype Writer w a = Writer { runWriter :: (a, w) }

-- runWriter :: Writer w a -> (a, w)

writer :: (a, w) -> Writer w a
writer = Writer

execWriter :: Writer w a -> w
execWriter m = snd $ runWriter m

evalWriter :: Writer w a -> a
evalWriter m = fst $ runWriter m

-- Запись в лог
tell :: Monoid w => w -> Writer w ()
tell w = writer ((), w)

instance (Monoid w) => Monad (Writer w) where
  return x = Writer (x, mempty)
  m >>= k =
    let (x, u) = runWriter m
        (y, v) = runWriter $ k x
    in Writer (y, u `mappend` v)

instance (Monoid w) => Applicative (Writer w) where
  pure  = undefined
  (<*>) = undefined

instance (Monoid w) => Functor (Writer w) where
  fmap = undefined

test1 = runWriter  (return 3 :: Writer String Int) == (3, "")
test2 = execWriter (return 3 :: Writer String Int) == ""
test3 = evalWriter (return 3 :: Writer String Int) == 3

tests = test1 && test2 && test3