module Demo where


import Text.Parsec


ignoreBraces :: Parsec [Char] u a -> Parsec [Char] u b -> Parsec [Char] u c -> Parsec [Char] u c
ignoreBraces brl brr p = brl *> p <* brr
-- ignoreBraces = between

testParserFunc = ignoreBraces (string "[[") (string "]]") (many1 letter)
testIgnoreBraces = parse testParserFunc "" "[[ABC]]DEF" == Right "ABC"
