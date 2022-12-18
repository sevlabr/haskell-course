module MyMonads where


----- State Monad -----
newtype State s a = State { runState :: s -> (a, s) }
-- runState :: State s a -> s -> (a, s)

instance Monad (State s) where
  return a = State $ \st -> (a, st)

  m >>= k = State $ \st ->
    let (a, st') = runState m st
        m' = k a
    in runState m' st'

instance Applicative (State s) where
  pure  = undefined
  (<*>) = undefined

instance Functor (State s) where
  fmap = undefined

execState :: State s a -> s -> s
execState m s = snd $ runState m s

evalState :: State s a -> s -> a
evalState m s = fst $ runState m s

-- Передаёт состояние (первый аргумент), не изменяя в процессе само состояние (второй аргумент)
-- Аналог ask (MyReader)
get :: State s s
get = State $ \st -> (st, st)

testGet = runState get 5 == (5, 5)

-- Оборачиваем аргумент в состояние (тем самым делая его текущим состоянием) и ничего не возвращаем
-- Аналог tell (MyWriter)
put :: s -> State s ()
put st = State $ \_ -> ((), st)

testPut = runState (put 7) 5 == ((), 7)

-- Пример
tick :: State Int Int
tick = do
  n <- get
  put (n + 1)
  return n

testTick = runState tick 5 == (5, 6)

-- (Это стрелка Клейсли)
modify :: (s -> s) -> State s ()
modify f = State $ \s -> ((), f s)

modify' :: (s -> s) -> State s ()
modify' f = do
  s <- get
  put $ f s

testModify = runState (modify (^2)) 5 == ((), 25)

testsMyState = all (== True) [testGet, testPut, testTick, testModify]



----- Reader Monad -----
data Reader r a = Reader { runReader :: (r -> a) }

instance Monad (Reader r) where
  return x = Reader $ \_ -> x
  m >>= k  = Reader $ \r -> runReader (k (runReader m r)) r

instance Applicative (Reader r) where
  pure  = undefined
  (<*>) = undefined

instance Functor (Reader r) where
  fmap = undefined

asks :: (r -> a) -> Reader r a
asks = Reader

local :: (r -> r) -> Reader r a -> Reader r a
local f m = Reader $ \e -> runReader m (f e)

local' :: (r -> r') -> Reader r' a -> Reader r a
local' f m = Reader $ \e -> runReader m (f e)



----- Writer Monad -----
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

testMyWriter1 = runWriter  (return 3 :: Writer String Int) == (3, "")
testMyWriter2 = execWriter (return 3 :: Writer String Int) == ""
testMyWriter3 = evalWriter (return 3 :: Writer String Int) == 3

testsMyWriter = all (== True) [testMyWriter1, testMyWriter2, testMyWriter3]


allMyMonadsTests = all (== True) [testsMyState, testsMyWriter]



----- Supplementary functions -----
-- (sequences and mapMs are already imported into Prelude by default)

sequence_' :: Monad m => [m a] -> m ()
sequence_' = foldr (>>) (return ())

mapM_' :: Monad m => (a -> m b) -> [a] -> m ()
mapM_' f = sequence_' . map f

sequence' :: Monad m => [m a] -> m [a]
sequence' ms = foldr k (return []) ms
  where
    k :: Monad m => m a -> m [a] -> m [a]
    k m m' = do
      x  <- m
      xs <- m'
      return (x:xs)

mapM' :: Monad m => (a -> m b) -> [a] -> m [b]
mapM' f = sequence' . map f

replicateM :: Monad m => Int -> m a -> m [a]
replicateM n = sequence' . replicate n

replicateM_ :: Monad m => Int -> m a -> m ()
replicateM_ n = sequence_' . replicate n
