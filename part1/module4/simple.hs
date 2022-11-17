module Simple where



-- GHCi> show Red
-- "Red"

data Color' = Red' | Green' | Blue'

instance Show Color' where
    show Red'   = "Red"
    show Green' = "Green"
    show Blue'  = "Blue"



-- GHCi> charToInt '0'
-- 0
-- GHCi> charToInt '9'
-- 9

charToInt :: Char -> Int
charToInt a = read [a] -- :: Int
-- charToInt '0' = 0
-- charToInt '1' = 1
-- charToInt '2' = 2
-- charToInt '3' = 3
-- charToInt '4' = 4
-- charToInt '5' = 5
-- charToInt '6' = 6
-- charToInt '7' = 7
-- charToInt '8' = 8
-- charToInt '9' = 9



-- GHCi> stringToColor "Red"
-- Red

data Color = Red | Green | Blue deriving(Show, Read)

stringToColor :: String -> Color
stringToColor = read

-- data Color = Red | Green | Blue deriving(Show)

-- stringToColor :: String -> Color
-- stringToColor "Red"   = Red
-- stringToColor "Green" = Green
-- stringToColor "Blue"  = Blue


data Person = Person { firstName :: String, lastName :: String, age :: Int } deriving(Show)

updateLastName :: Person -> Person -> Person
updateLastName p1 p2 = p2 {lastName = lastName p1}

testUpdateLastName =
    let
      p1 = Person { firstName = "John", lastName = "Jefferson", age = 33}
      p2 = Person { firstName = "Ashley", lastName = "Brown", age = 31}
    in
      updateLastName p1 p2
