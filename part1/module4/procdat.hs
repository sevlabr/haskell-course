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
