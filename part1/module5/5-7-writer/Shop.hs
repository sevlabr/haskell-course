module Demo where


import MyWriter
import Data.Monoid

type Shopping = Writer (Sum Integer) ()

purchase :: String -> Integer -> Shopping
purchase item cost = tell $ Sum cost

total :: Shopping -> Integer
total = getSum . execWriter

shopping1 :: Shopping
shopping1 = do
  purchase "Jeans"   19200
  purchase "Water"     180
  purchase "Lettuce"   328

testShopping = total shopping1 == 19708


type Shopping' = Writer (([String], Sum Integer)) ()

purchase' :: String -> Integer -> Shopping'
purchase' item cost = tell $ ([item], Sum cost)

total' :: Shopping' -> Integer
total' = getSum . snd . execWriter

items :: Shopping' -> [String]
items = fst . execWriter

shopping1' :: Shopping'
shopping1' = do
  purchase' "Jeans"   19200
  purchase' "Water"     180
  purchase' "Lettuce"   328

testShopping' = total' shopping1' == 19708
                && items shopping1' == ["Jeans", "Water", "Lettuce"]
