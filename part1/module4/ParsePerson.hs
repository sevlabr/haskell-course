module ParsePerson where


import Data.List
import Data.Char


data Error = ParsingError | IncompleteDataError | IncorrectDataError String
  deriving (Show)

data Person = Person { firstName :: String, lastName :: String, age :: Int }
  deriving (Show)

parsePerson :: String -> Either Error Person
parsePerson inp = procPerson $ lines inp
  where
    procPerson :: [String] -> Either Error Person
    procPerson fields | length fields <= 2       = Left IncompleteDataError
                      | not $ checkXEqY fields   = Left ParsingError
                      | length extrFlds <= 2     = Left IncompleteDataError
                      | not $ checkAgeVal ageVal = Left (IncorrectDataError ageVal)
                      | otherwise                = Right person
      where
        extrFlds = buildPerson fields
        ageVal   = last extrFlds
        person   = Person {firstName = extrFlds!!0, lastName = extrFlds!!1, age = ((read $ extrFlds!!2) :: Int)}

-- checks if every string in the list has the following structure: "X = Y"
checkXEqY :: [String] -> Bool
checkXEqY fields = all (\inp -> checkLeft inp && checkRight inp) fields
  where
    checkLeft :: String -> Bool
    checkLeft inp | left == []                            = False
                  | last left == ' ' && head left /= ' '  = True
                  | otherwise                             = False
      where
        left = takeWhile (\c -> c /= '=') inp
    
    checkRight :: String -> Bool
    checkRight inp | right == []                            = False
                   | head right == ' ' && length right >= 2 = True
                   | otherwise                              = False
      where
        right = tail' $ dropWhile (\c -> c /= '=') inp

-- gets values for each of 3 fields: firstName, lastName, age
buildPerson :: [String] -> [String]
buildPerson [] = []
buildPerson (f:fs) | checkFirstName f = (getFirstName f) : buildPerson fs
                   | checkLastName  f = (getLastName  f) : buildPerson fs
                   | checkAge       f = (getAge       f) : buildPerson fs
                   | otherwise        = buildPerson fs

-- checks if X is firstName in a "X = Y" string
checkFirstName :: String -> Bool
checkFirstName inp = isPrefixOf "firstName" inp

-- checks if X is lastName in a "X = Y" string
checkLastName :: String -> Bool
checkLastName inp = isPrefixOf "lastName" inp

-- checks if X is age in a "X = Y" string
checkAge :: String -> Bool
checkAge inp = isPrefixOf "age" inp

-- get firstName value Y in a "firstName = Y" string
getFirstName :: String -> String
getFirstName inp =
  let
    right  = dropWhile (\c -> c /= '=') inp
    right' = tail' right
    fname  = tail' right'
  in
    fname

-- get lastName value Y in a "lastName = Y" string
getLastName :: String -> String
getLastName inp =
  let
    right  = dropWhile (\c -> c /= '=') inp
    right' = tail' right
    lname  = tail' right'
  in
    lname

-- get age value Y in a "age = Y" string
getAge :: String -> String
getAge inp =
  let
    right  = dropWhile (\c -> c /= '=') inp
    right' = tail' right
    age    = tail' right'
  in
    age

-- checks if age is a number
checkAgeVal :: String -> Bool
checkAgeVal val = all (\c -> isDigit c) val

tail' :: [a] -> [a]
tail' [] = []
tail' l = tail l
