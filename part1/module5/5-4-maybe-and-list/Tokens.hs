-- This is a proto Lexer
module Demo where


import Data.Char

data Token = Number Int | Plus | Minus | LeftBrace | RightBrace 
  deriving (Eq, Show)

asToken :: String -> Maybe Token
asToken str | str == "+"      = Just Plus
            | str == "-"      = Just Minus
            | str == "("      = Just LeftBrace
            | str == ")"      = Just RightBrace
            | all isDigit str = Just (Number $ read str)
            | otherwise       = Nothing

test1 = (asToken "123") == Just (Number 123)
test2 = (asToken "abc") == Nothing

tokenize :: String -> Maybe [Token]
tokenize str = convertToTokens $ words str
  where
    convertToTokens :: [String] -> Maybe [Token]
    convertToTokens []     = Just []
    convertToTokens (t:ts) = do
      tok  <- asToken t
      toks <- convertToTokens ts
      return (tok:toks)

test3 = (tokenize "1 + 2")         == Just [Number 1,Plus,Number 2]
test4 = (tokenize "1 + ( 7 - 2 )") == Just [Number 1,Plus,LeftBrace,Number 7,Minus,Number 2,RightBrace]
test5 = (tokenize "1 + abc")       == Nothing

tests = test1 && test2 && test3 && test4 && test5
