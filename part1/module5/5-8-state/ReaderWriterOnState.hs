module Demo where


import MyMonads


----- State to Reader -----

-- state becomes constant and value is changing as Reader dictates
readerToState :: Reader r a -> State r a
readerToState m = State $ \s -> (runReader m s, s)

-- runReader запускает хранящееся в Reader вычисление f на переданном окружении s
readerToState' :: Reader r a -> State r a
readerToState' (Reader f) = State $ \s -> (f s, s)

-- Т.е. в итоге работаем в монаде State, и рабочая монада определяется возвращаемым значением
readerToState'' :: Reader r a -> State r a
readerToState'' m = do 
   st <- get 
   return $ runReader m st

-- Очень абстрактно (к тому же, у меня тут пока 'fmap = undefined' для 'instance Functor (State s)', так что выдаёт undefined)
readerToState''' :: Reader r a -> State r a
readerToState''' m = fmap (runReader m) get

testReaderToState1 = evalState (readerToState $ asks (+2)) 4 == 6
testReaderToState2 = runState  (readerToState $ asks (+2)) 4 == (6, 4)



----- State to Writer -----

writerToState :: Monoid w => Writer w a -> State w a
writerToState m = State $ \s ->
                    let (v, l) = runWriter m
                        s' = s `mappend` l
                    in (v, s')

-- Ещё одна интерпретация
-- (говорят, что со стандартным Writer из Control.Monad.Writer не будет работать)
-- (тем более, что там есть WriterT и MonadWriter, возвращаемый writer)
writerToState' :: Monoid w => Writer w a -> State w a
writerToState' (Writer (a, l)) = State $ \s -> (a, s `mappend` l)

-- Note that in case of Writer a log would contain only mempty,
-- but State allows to set an initial value ("hello" or mempty here)
testWriterToState1 = runState (writerToState $ tell "world") "hello," == ((),"hello,world")
testWriterToState2 = runState (writerToState $ tell "world") mempty   == ((),"world")


----- Combined tests -----
readerWriterToStateTests = all (== True) [testReaderToState1, testReaderToState2, testWriterToState1, testWriterToState2]
