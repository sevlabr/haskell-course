module Demo where


data Log a = Log [String] a  deriving (Show, Eq)

returnLog :: a -> Log a
returnLog x = Log [] x

testReturnLog = returnLog 2

checkTests = testReturnLog == Log [] 2
