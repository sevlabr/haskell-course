module Demo where


data Log a = Log [String] a  deriving (Show, Eq)

toLogger :: (a -> b) -> String -> (a -> Log b)
toLogger f s = (\x -> Log [s] (f x)) 

add1Log = toLogger (+1) "added one"
mult2Log = toLogger (* 2) "multiplied by 2"
testToLoggerAdd = add1Log 3
testToLoggerMult = mult2Log 3
testToLoggerCheck = (testToLoggerAdd == Log ["added one"] 4) && (testToLoggerMult == Log ["multiplied by 2"] 6)

execLoggers :: a -> (a -> Log b) -> (b -> Log c) -> Log c
execLoggers x f1 f2 =
  let
    Log s1 r1 = f1 x
    Log s2 r2 = f2 r1
  in
    Log (s1 ++ s2) r2

testExecLoggers = execLoggers 3 add1Log mult2Log
testExecLoggersCheck = testExecLoggers == Log ["added one","multiplied by 2"] 8

checkTests = testToLoggerCheck && testExecLoggersCheck
