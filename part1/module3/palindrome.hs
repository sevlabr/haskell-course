module Palindrome where


myReverse :: [a] -> [a] -> [a]
myReverse (x : []) acc = x : acc
myReverse (x : xs) acc = myReverse xs (x : acc) 

-- GHCi> isPalindrome "saippuakivikauppias"
-- True
-- GHCi> isPalindrome [1]
-- True
-- GHCi> isPalindrome [1, 2]
-- False
isPalindrome :: Eq a => [a] -> Bool
isPalindrome []  = True
isPalindrome lst | length lst == 1 = True
                 | otherwise       = (myReverse lst []) == lst

isPalindrome' :: Eq a => [a] -> Bool
isPalindrome' lst = (reverse lst) == lst
-- (by palindrome definition)
