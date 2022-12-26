module Demo where


-- Pointed law:
-- fmap g (pure x) == pure (g x)
-- Если fmap реализован корректно, то этот закон выполняется автоматически
-- Это так называемая свободная теорема
-- (тут имеется ввиду, что она получается "бесплатно", сама собой, её не нужно доказывать)

-- Связь Functor и Applicative:
-- fmap g cont == pure g <*> cont
-- cont :: f a
-- g :: a -> b
-- pure g :: f (a -> b)
-- pure g <*> cont :: f b
-- (+) <$> Just 2 <*> Just 5 == 7

-- Законы для Applicative:
-- 1) Identity:
--    pure id <*> v == v
-- 2) Homomorphism:
--    pure g <*> pure x == pure (g x)
--    (Example: pure length <*> pure "ABCD" :: Maybe Int == pure (length "ABCD") :: Maybe Int == Just 4)
-- 3) Interchange (что-то типа коммутативности):
--    cont <*> pure x == pure ($ x) <*> cont
--    (Example: Just (^2) <*> pure 3 == pure ($ 3) <*> Just (^2) == Just 9)
--    Тут можно заметить, что, в отличие от монад, при работе с Applicative порядок не важен
--    В монаде порядок важен. От результата предыдущего вычисления может зависеть результат следующего (имеется ввиду, внутри монады)
--    (Параллели с функциональностью (Applicative) и императивностью (Monad))
-- 4) Composition:
--    pure (.) <*> u <*> v <*> cont == u <*> (v <*> cont)
--    Examples: Just (^2) <*> (Just succ <*> Just 3) == Just 16
--              (^2) (succ 3) == ((^2) . succ) 3 == ((.) (^2) succ) 3 == (.) (^2) succ 3 == 16
--              pure (.) <*> Just (^2) <*> Just succ <*> Just 3 == Just 16


-- Check for 1.2.3:
pure' :: a -> [a]
pure' x = [x, x]

identityLeft  = pure' id <*> [1, 2, 3] -- [1,2,3,1,2,3]
identityRight = [1, 2, 3]
checkIdentity = identityLeft == identityRight

homomorphismLeft  = pure' (\x -> x * 2) <*> pure' 1 -- [2,2,2,2]
homomorphismRight = pure' ((\x -> x * 2) 1) -- [2,2]
checkHomomorphism = homomorphismLeft == homomorphismRight

interchangeLeft  = [\x -> x * 2, \x -> x^2, \x -> x - 3] <*> pure' 2 -- [4,4,4,4,-1,-1]
interchangeRight = pure' ($ 2) <*> [\x -> x * 2, \x -> x^2, \x -> x - 3] -- [4,4,-1,4,4,-1]
checkInterchange = interchangeLeft == interchangeRight -- (!!!) Это верно, но с точностью до перестановки

-- В задаче указано другое условие: вместо pure (.) там указано просто (.)
-- Если так ставить задачу, то этот закон выполняется
-- Но условие неверно, в чём можно убедиться здесь: https://wiki.haskell.org/Typeclassopedia#Applicative
-- В комментариях автор указывает, что pure (.) и (.) суть одно и то же,
-- но это выполняется только в случае каноничной реализации: pure x = [x]
-- В случае же pure x = [x, x] это неверно
-- [4,5,6,7,8,2,3,4,5,6,12,12,12,12,12,-4,-3,-2,-1,0,-6,-5,-4,-3,-2,4,4,4,4,4,4,5,6,7,8,2,3,4,5,6,12,12,12,12,12,-4,-3,-2,-1,0,-6,-5,-4,-3,-2,4,4,4,4,4]
compositionLeft  = pure' (.) <*> [\x -> x + 2, \x -> x - 6] <*> [succ, pred, \_ -> 10] <*> [1, 2, 3, 4, 5]
-- [4,5,6,7,8,2,3,4,5,6,12,12,12,12,12,-4,-3,-2,-1,0,-6,-5,-4,-3,-2,4,4,4,4,4]
compositionRight = [\x -> x + 2, \x -> x - 6] <*> ([succ, pred, \_ -> 10] <*> [1, 2, 3, 4, 5])
checkComposition = compositionLeft == compositionRight

applicativeFunctorLeft  = (\x -> x - 5) <$> [1, 4, 5] -- [-4,-1,0]
applicativeFunctorRight = pure' (\x -> x - 5) <*> [1, 4, 5] -- [-4,-1,0,-4,-1,0]
checkApplicativeFunctor = applicativeFunctorLeft == applicativeFunctorRight

main' :: IO ()
main' = do
  print identityLeft
  print identityRight
  print homomorphismLeft
  print homomorphismRight
  print interchangeLeft
  print interchangeRight
  print compositionLeft
  print compositionRight
  print applicativeFunctorLeft
  print applicativeFunctorRight

main'' :: IO ()
main'' = mapM_ print [identityLeft, identityRight,
                      homomorphismLeft, homomorphismRight,
                      interchangeLeft, interchangeRight,
                      compositionLeft, compositionRight,
                      applicativeFunctorLeft, applicativeFunctorRight]
