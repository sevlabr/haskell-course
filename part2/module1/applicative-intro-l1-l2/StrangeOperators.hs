{-
liftA2 :: Applicative f => (a -> b -> c) -> f a -> f b -> f c
liftA2 f a b = f <$> a <*> b

infixl 4 <**>
(<**>) :: Applicative f => f a -> f (a -> b) -> f b
(<**>) = liftA2 (flip ($))

infixl 4 <*?>
(<*?>) :: Applicative f => f a -> f (a -> b) -> f b
(<*?>) = flip (<*>)


-- The idea is that result gets affected in the presence of
-- operations with different priority and in case of structures
-- where order matters.

{-# LANGUAGE RankNTypes#-} -- Seems like it lets us define "infixl 4 <??>" inside let-in construction
import Control.Applicative ((<**>),ZipList(..))

infixl 4 <*?>
(<*?>) :: Applicative f => f a -> f (a -> b) -> f b
(<*?>) = flip (<*>)

exprMaybe :: (forall a b . Maybe a -> Maybe (a -> b) -> Maybe b) -> Maybe Int
exprMaybe op = 
  let (<??>) = op 
      infixl 4 <??> 
  in Just 5 <??> Just (+2) -- Just is a simple container

exprList :: (forall a b . [a] -> [a -> b] -> [b]) -> [Int]
exprList op = 
  let (<??>) = op 
      infixl 4 <??> 
  in [1,2] <??> [(+3),(*4)] -- changed '+' on '*' in front of 4; in lists order matters

exprZipList :: (forall a b . ZipList a -> ZipList (a -> b) -> ZipList b) -> ZipList Int
exprZipList op = 
  let (<??>) = op 
      infixl 4 <??> 
  in ZipList [1,2] <??> ZipList [(+3),(+4)]  -- in ZipList order does not matter

exprEither :: (forall a b . Either String a -> Either String (a -> b) -> Either String b) -> Either String Int
exprEither op = 
  let (<??>) = op 
      infixl 4 <??> 
  -- in Left "AA" <??> Right (+1)  -- place for counterexample
  in Left "AA" <??> Left "ABC"

exprPair :: (forall a b . (String,a) -> (String,a -> b) -> (String,b)) -> (String,Int)
exprPair op = 
  let (<??>) = op 
      infixl 4 <??> 
  -- in ("AA", 3) <??> ("",(+1))  -- place for counterexample
  in ("AA", 3) <??> ("BC",(+1))

exprEnv :: (forall a b . (String -> a) -> (String -> (a -> b)) -> (String -> b)) -> (String -> Int)
exprEnv op = 
  let (<??>) = op 
      infixl 4 <??> 
  in length <??> (\_ -> (+5))  -- place for counterexample

-}