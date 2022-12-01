module Demo where


data Log a = Log [String] a  deriving (Show, Eq)

toLogger :: (a -> b) -> String -> (a -> Log b)
toLogger f s = (\x -> Log [s] (f x)) 

bindLog :: Log a -> (a -> Log b) -> Log b
bindLog (Log msgInit valInit) f =
  let
    Log msg val = f valInit
  in
    Log (msgInit ++ msg) val

add1Log = toLogger (+1) "added one"
mult2Log = toLogger (* 2) "multiplied by 2"

testBindLog1 = Log ["nothing done yet"] 0 `bindLog` add1Log
testBindLog1Check = testBindLog1 == Log ["nothing done yet","added one"] 1

testBindLog2 = Log ["nothing done yet"] 3 `bindLog` add1Log `bindLog` mult2Log
testBindLog2Check = testBindLog2 == Log ["nothing done yet","added one","multiplied by 2"] 8

checkTests = testBindLog1Check && testBindLog2Check
