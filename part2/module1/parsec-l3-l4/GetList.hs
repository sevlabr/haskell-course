module Demo where


import Text.Parsec

getList :: Parsec String u [String]
getList = many1 digit `sepBy` (char ';')

testGetList = parse getList "" "1;234;56" == Right ["1","234","56"]
-- Error: parseTest getList "1;234;56;"
-- Error: parseTest getList "1;;234;56"
