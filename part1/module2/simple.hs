module Simple where

import Data.Function -- for multSecond

getSecondFrom :: a -> b -> c -> b
getSecondFrom x y z = y

-- GHCi> multSecond ('A',2) ('E',7)
-- 14

multSecond = g' `on` h'
g' = (*)
h' = snd

-- GHCi> let sum3squares = (\x y z -> x+y+z) `on3` (^2)
-- GHCi> sum3squares 1 2 3
-- 14

on3 :: (b -> b -> b -> c) -> (a -> b) -> a -> a -> a -> c
on3 op f x y z = op (f x) (f y) (f z)


doItYourself = f . g . h

-- logBase 2 x
-- f = \x -> logBase 2 x
f = logBase 2

-- x^3
-- g = \x -> x^3
g = (^3)

-- max x 42
-- h = \x -> max x 42
h = max 42
