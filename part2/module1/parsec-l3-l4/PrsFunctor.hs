module Demo where


import Data.Char


newtype Prs a = Prs { runPrs :: String -> Maybe (a, String) }


instance Functor Prs where
  fmap f p = Prs fun
    where
      fun = \s -> do -- working in Maybe Monad
        pRes <- runPrs p s
        let s' = snd pRes
        let fRes = f (fst pRes)
        return (fRes, s')

anyChr :: Prs Char
anyChr = Prs $ \s -> if s == [] then Nothing else Just (head s, tail s)


testPrsFunctor1 = runPrs anyChr "ABC" == Just ('A',"BC")
testPrsFunctor2 = runPrs anyChr ""    == Nothing
testPrsFunctor3 = runPrs (digitToInt <$> anyChr) "BCD" == Just (11,"CD")

-- It may be useful to check other solutions on Stepik
