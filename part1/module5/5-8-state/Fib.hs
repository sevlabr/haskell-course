module Demo where


import MyMonads

fibStep :: State (Integer, Integer) ()
fibStep = do
  (a, b) <- get
  put (b, a + b)

fibStep' :: State (Integer, Integer) ()
fibStep' = modify $ \(a, b) -> (b, a + b)

testFibStep1 = execState fibStep (0, 1) == (1, 1)
testFibStep2 = execState fibStep (1, 1) == (1, 2)
testFibStep3 = execState fibStep (1, 2) == (2, 3)
testFibStep  = all (== True) [testFibStep1, testFibStep2, testFibStep3]

execStateN :: Int -> State s a -> s -> s
execStateN n m = snd . runState (sequence_ $ replicate n m)

execStateN' :: Int -> State s a -> s -> s
execStateN' n m = execState $ replicateM_ n m

fib :: Int -> Integer
fib n = fst $ execStateN n fibStep (0, 1)
