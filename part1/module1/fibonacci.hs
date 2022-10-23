module Fib where

fib_acc :: Integer -> Integer -> Integer -> Integer
fib_acc n a b | n == 0 = a
              | n == 1 = b
              | n >  1 = fib_acc (n - 1) b (a + b)
              | n <  0 = fib_acc (n + 1) (b - a) a

fibonacci :: Integer -> Integer
fibonacci n = fib_acc n 0 1
 
fibonacci_ordinary :: Integer -> Integer
fibonacci_ordinary n | n == 0    = 0
                     | n == 1    = 1
                     | n >  0    = fibonacci_ordinary (n - 1) + fibonacci_ordinary (n - 2)
                     | n == (-1) = 1
                     | n == (-2) = (-1)
                     | n <  0    = fibonacci_ordinary (n + 2) - fibonacci_ordinary (n + 1)
                     | otherwise = undefined
