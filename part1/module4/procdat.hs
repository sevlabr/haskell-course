module ProcDat where


-- *ProcDat> processData Foo
-- "Success"
-- *ProcDat> processData Bar
-- "Fail: 3"

data Result = Fail | Success

data SomeData = Foo | Bar | FooBar

doSomeWork :: SomeData -> (Result, Int)
doSomeWork Foo = (Success, 0)
doSomeWork _   = (Fail,    3)

processData :: SomeData -> String
processData val =
  case doSomeWork val of
    (Success, _) -> "Success"
    (_      , n) -> "Fail: " ++ show n

-- case _ of {_; _}

data Result' = Result' Result Int
-- data Result' = Result Int | Success

instance Show Result' where
    show (Result' Success _) = "Success"
    show (Result' Fail    n) = "Fail: " ++ show n

doSomeWork' :: SomeData -> Result'
doSomeWork' val =
  case doSomeWork val of
    (Success, _) -> Result' Success 0
    (_      , n) -> Result' Fail    n


-- One more solution:
data Result'' = Fail'' Int | Success'' 

instance Show Result'' where
    show (Fail'' n) = "Fail: " ++ show n
    show _          = "Success"

doSomeWork'' :: SomeData -> Result''
doSomeWork'' x = case doSomeWork x of
                  (Success, _) -> Success''
                  (_      , n) -> Fail'' n
