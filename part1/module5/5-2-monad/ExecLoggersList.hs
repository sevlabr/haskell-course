module Demo where


import Control.Monad (liftM, ap)


data Log a = Log [String] a  deriving (Show, Eq)

toLogger :: (a -> b) -> String -> (a -> Log b)
toLogger f s = (\x -> Log [s] (f x)) 

returnLog :: a -> Log a
returnLog x = Log [] x

bindLog :: Log a -> (a -> Log b) -> Log b
bindLog (Log msgInit valInit) f =
  let
    Log msg val = f valInit
  in
    Log (msgInit ++ msg) val

instance Functor Log where
  fmap = liftM
 
instance Applicative Log where
  pure  = return
  (<*>) = ap

instance Monad Log where
  return = returnLog
  (>>=) = bindLog

execLoggersList :: a -> [a -> Log a] -> Log a
execLoggersList val []     = return val
execLoggersList val (f:fs) =
  let
    Log msg  newVal = return val >>= f
    Log msgs finVal = execLoggersList newVal fs
  in
    Log (msg ++ msgs) finVal


add1Log = toLogger (+1) "added one"
mult2Log = toLogger (* 2) "multiplied by 2"
testExecLoggersList = execLoggersList 3 [add1Log, mult2Log, \x -> Log ["multiplied by 100"] (x * 100)]
checkTest = testExecLoggersList == Log ["added one","multiplied by 2","multiplied by 100"] 800
