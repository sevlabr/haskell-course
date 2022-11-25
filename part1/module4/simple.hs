module Simple where

import Data.Char



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

abbrFirstName :: Person -> Person
abbrFirstName p@(Person {firstName = fn}) | length fn <= 1 = p
                                          | otherwise      = p {firstName = [head fn] ++ "."}

testAbbrFirstName =
    let
        p1 = Person "Ivan" "Bogdanoff" 23
        p2 = Person "A"    "Brown"     20
    in
        (abbrFirstName p1, abbrFirstName p2)


findDigit :: [Char] -> Maybe Char
findDigit [] = Nothing
findDigit (c:cs) | isDigit c = Just c
                 | otherwise = findDigit cs

findDigitOrX :: [Char] -> Char
findDigitOrX cs =
    case findDigit cs of
        Nothing -> 'X'
        Just c  -> c

-- maybeToList $ Just (1::Int) = [1]
-- maybeToList $ Nothing = []
maybeToList :: Maybe a -> [a]
maybeToList ma =
    case ma of
        Nothing -> []
        Just a  -> [a]

-- listToMaybe [1,2,3] = Just 1
-- listToMaybe [] = Nothing
listToMaybe :: [a] -> Maybe a
listToMaybe []     = Nothing
listToMaybe (a:as) = Just a


eitherToMaybe :: Either a b -> Maybe a
eitherToMaybe (Left  a) = Just a
eitherToMaybe (Right _) = Nothing

-- 2 :+ 5 means complex number (2 + i*5)
-- 2 :+ (-5) means complex number (2 - i*5)
-- They are defined in Data.Complex and use strict constructor (eager behaviour, not lazy) with "!", like: data Coord a = Coord !a !a
-- Data.Ratio: !a :% !a
-- Это инфиксный конструктор данных

-- Чтобы компилятор понимал, что происходит, они обозначаются всегда с ":" в начале. По аналогии с конструкторами данных с больших букв


data List a = Nil | Cons a (List a)

fromList :: List a -> [a]
fromList Nil         = []
fromList (Cons l ls) = l : fromList ls

toList :: [a] -> List a
toList []     = Nil
toList (l:ls) = Cons l (toList ls)
