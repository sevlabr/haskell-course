module Odd where


data Odd = Odd Integer 
  deriving (Eq, Show)

addEven :: Odd -> Integer -> Odd
addEven (Odd n) m | m `mod` 2 == 0 = Odd (n + m)
                  | otherwise      = error "addEven: second parameter cannot be odd"

instance Enum Odd where
  succ (Odd x) = Odd $ x + 2
  pred (Odd x) = Odd $ x - 2

  toEnum x         = Odd $ toInteger x * 2 + 1
  fromEnum (Odd x) = quot (fromInteger x - 1) 2
  
  enumFrom = iterate succ

  enumFromThen   (Odd x) (Odd y)         = map Odd [x, y ..]
  enumFromTo     (Odd x) (Odd y)         = map Odd [x, x + 2 .. y]
  enumFromThenTo (Odd x) (Odd y) (Odd z) = map Odd [x, y .. z]



--------------- TESTS ---------------

-- Большое число, которое не поместится в Int
baseVal = 9900000000000000000

-- Генератор значений для тестирования
testVal n = Odd $ baseVal + n

-- Для проверки самих тестов. Тесты с 0..3 не должны выполняться, так как
-- будет не Odd, а обычные числа, на которых определены привычные операции
-- testVal = id

test0 = succ (testVal 1) == (testVal 3)
test1 = pred (testVal 3) == (testVal 1)

-- enumFrom
test2 = take 4 [testVal 1 ..] == [testVal 1, testVal 3, testVal 5, testVal 7]

-- enumFromTo
-- -- По возрастанию
test3 = take 9 [testVal 1 .. testVal 7] == [testVal 1, testVal 3, testVal 5, testVal 7]
-- -- По убыванию
test4 = take 3 [testVal 7 .. testVal 1] == []

-- enumFromThen
-- -- По возрастанию
test5 = take 4 [testVal 1, testVal 5 ..] == [testVal 1, testVal 5, testVal 9, testVal 13]
-- -- По убыванию
test6 = take 4 [testVal 5, testVal 3 ..] == [testVal 5, testVal 3, testVal 1, testVal (-1)]

-- enumFromThenTo
-- -- По возрастанию
test7 = [testVal 1, testVal 5 .. testVal 11] == [testVal 1, testVal 5, testVal 9]
-- -- По убыванию
test8 = [testVal 7, testVal 5 .. testVal 1]  == [testVal 7, testVal 5, testVal 3, testVal 1]
-- -- x1 < x3 && x1 > x2
test9 = [testVal 7, testVal 5 .. testVal 11] == []
-- -- x1 > x3 && x1 < x2
test10 = [testVal 3, testVal 5 .. testVal 1] == []

-- Дополнительные тесты на случаи типа: [1, 1 ..]; [1, 1 .. 1]; [1, 0 .. 1] и т.д.
test11 = take 4 [testVal 5, testVal 5 .. ]           == replicate 4 (testVal 5)
test12 = take 4 [testVal 5, testVal 5 .. testVal 11] == replicate 4 (testVal 5)
test13 = take 4 [testVal 5, testVal 5 .. testVal 5]  == replicate 4 (testVal 5)
test14 =        [testVal 5, testVal 5 .. testVal 3]  ==             []
test15 =        [testVal 5, testVal 1 .. testVal 5]  ==             [testVal 5]
test16 =        [testVal 5, testVal 3 .. testVal 3]  ==             [testVal 5, testVal 3]

-- toEnum & fromEnum
test17 = toEnum (fromEnum (Odd 3)) == Odd 3

-- Это сомнительный тест. Скорее всего, его нет на Stepik
test18 = fromEnum (Odd 3) + 1 == fromEnum (Odd 5)

-- Статистика по тестам
testList = [test0, test1, test2, test3, test4, test5, test6, test7, test8, test9,
            test10, test11, test12, test13, test14, test15, test16, test17, test18]
allTests = zip [0..] testList
-- -- Список тестов с ошибками
badTests = map fst $ filter (not . snd) allTests
