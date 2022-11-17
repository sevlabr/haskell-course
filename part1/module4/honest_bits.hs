module Demo where


import Data.List

data Bit = Zero | One deriving Eq
data Sign = Minus | Plus deriving Eq
data Z = Z Sign [Bit]

instance Show Bit where
    show b | b == One  = "1"
           | otherwise = "0"

instance Show Sign where
    show s | s == Plus = "+"
           | otherwise = "-"

instance Show Z where
    show (Z s bs) = "Z: " ++ show s ++ show bs

instance Eq Z where
    (==) (Z s1 bs1) (Z s2 bs2)
        | s1 == s2 && bs1 == bs2 = True
        | otherwise              = False

instance Ord Bit where
    (<=) Zero One = True
    (<=) One Zero = False
    (<=) _ _ = True

instance Ord Z where
    (<=) z1@(Z s1 bs1) z2@(Z s2 bs2)
         | z1 == z2                             = True
         | s1 /= s2                             = if s1 == Plus then False else True
         | s1 == s2 && length bs1 >  length bs2 = if s1 == Plus then False else True
         | s1 == s2 && length bs1 <  length bs2 = if s1 == Plus then True else False
         | s1 == s2 && length bs1 == length bs2 = if s1 == Plus
                                                  then bitwiseComparisonResult
                                                  else not bitwiseComparisonResult
                                                  where bitwiseComparisonResult = reverse bs1 <= reverse bs2

invertBit :: Bit -> Bit
invertBit b = case b of
                One  -> Zero
                Zero -> One

zabs :: Z -> Z
zabs (Z _ bs) = (Z Plus bs)

(|>|) :: Z -> Z -> Bool
(|>|) z1 z2 = zabs z1 > zabs z2

-- Result: (Sum result, Carried over bit)
sumBitPair :: (Bit, Bit) -> (Bit, Bit)
sumBitPair (Zero, Zero) = (Zero, Zero)
sumBitPair (One, One)   = (Zero,  One)
sumBitPair (_, _)       = (One,  Zero)

foldBitSums :: ([Bit], Bit) -> (Bit, Bit) -> ([Bit], Bit)
foldBitSums ([],     Zero)           (b1, b2)    = ([b1], b2)
foldBitSums (sumRes, carriedOverBit) (Zero, b2)  = (sumRes ++ [carriedOverBit], b2)
foldBitSums (sumRes, carriedOverBit) (One, Zero) = (sumRes ++ [headBit], tailBit)
                                                   where
                                                   (headBit, tailBit) = sumBitPair (One, carriedOverBit)

concludeFolding :: ([Bit], Bit) -> [Bit]
concludeFolding (bitSum, Zero) = bitSum
concludeFolding (bitSum, One)  = bitSum ++ [One]

addLeadingZeros :: [Bit] -> Int -> [Bit]
addLeadingZeros bs zeroCount = bs ++ (take zeroCount $ repeat Zero)

addTrailingZeros :: [Bit] -> Int -> [Bit]
addTrailingZeros bs zeroCount = (take zeroCount $ repeat Zero) ++ bs

dropLeadingZeros :: [Bit] -> [Bit]
dropLeadingZeros bs = fst $ foldr fn ([], False) bs
                      where
                      fn = (\bit (bits, firstOneMet) -> if firstOneMet || bit == One
                                                        then (bit:bits, True)
                                                        else (bits, False))

getLenDiff :: [Bit] -> [Bit] -> Int
getLenDiff bs1 bs2 = length bs1 - length bs2

sumPreparedBits :: [Bit] -> [Bit] -> [Bit]
sumPreparedBits bs1 bs2 = concludeFolding $
                          foldl' foldBitSums ([], Zero) $
                          map sumBitPair $
                          zip bs1 bs2

sumBits :: [Bit] -> [Bit] -> [Bit]
sumBits bs1 bs2 | lenDiff >= 0 = sumPreparedBits bs1 $ addLeadingZeros bs2 lenDiff
                | lenDiff <  0 = sumBits bs2 bs1
                                  where lenDiff = getLenDiff bs1 bs2

substractBitPair :: (Bit, Bit) -> Z
substractBitPair (One, Zero) = Z Plus [One]
substractBitPair (Zero, One) = Z Minus [One]
substractBitPair (_, _)      = Z Plus [Zero]

countNegZs :: [Z] -> Int
countNegZs zs = foldr (\(Z s _) acc -> if s == Plus then acc else acc + 1) 0 zs

lowerRankByNegZCount :: [Z] -> Int -> [Bit]
lowerRankByNegZCount zs count = drop count $ map fn zs
                                where
                                fn (Z s (bit:[])) = if s == Plus then bit else Zero
                                fn (Z s (bit:_))  = error "[Z] must be a list of one-digit Z elements only"

cmp :: [Bit] -> [Bit] -> Ordering
cmp bs1 bs2 =      if length bs1  < length bs2  then LT
              else if length bs1  > length bs2  then GT
              else if reverse bs1 < reverse bs2 then LT
              else if reverse bs1 > reverse bs2 then GT
              else EQ

getAbsBitDiff :: [Bit] -> [Bit] -> [Bit]
getAbsBitDiff bs1 bs2 | cmp bs1 bs2 == LT = getAbsBitDiff bs2 bs1
                      | otherwise         = dropLeadingZeros $ take (length absBitDiff - 1) absBitDiff
                                            where
                                            lenDiff    = getLenDiff bs1 bs2
                                            absBitDiff = sumBits bs1 $
                                                         sumBits [One] $
                                                         map invertBit $
                                                         addLeadingZeros bs2 lenDiff

add :: Z -> Z -> Z
add z1@(Z s1 bs1) z2@(Z s2 bs2) | s1  == s2  = Z s1 $ sumBits bs1 bs2
                                | bs1 == bs2 = Z Plus []
                                | z1 |>| z2  = Z s1 $ getAbsBitDiff bs1 bs2
                                | otherwise  = Z s2 $ getAbsBitDiff bs1 bs2

getAdditionValues :: [Bit] -> [Bit] -> [[Bit]]
getAdditionValues bs1 bs2 = fst $ foldr fn ([], length bs2 - 1) bs2
                            where
                            fn = (\b2 (acc, rank) -> if b2 == Zero
                                                     then (acc, rank - 1)
                                                     else (addTrailingZeros bs1 rank : acc, rank - 1))

mul :: Z -> Z -> Z
mul (Z s1 []) (Z s2 _)    = Z Plus []
mul (Z s1 _) (Z s2 [])    = Z Plus []
mul (Z s1 bs1) (Z s2 bs2) = Z (getMulSign s1 s2) (getMulAmount bs1 bs2)
                                  where
                                  getMulSign s1 s2 | s1 == s2  = Plus
                                                   | otherwise = Minus
                                  getMulAmount [Zero] _ = [Zero]
                                  getMulAmount _ [Zero] = [Zero]
                                  getMulAmount bs1 bs2  = foldr1 (\bs1' bs2' -> sumBits bs1' bs2') $
                                                          getAdditionValues bs1 bs2


----- TESTS -----
test001 = (add (Z Plus []) (Z Plus [])) == Z Plus []
test002 = (add (Z Plus []) (Z Plus [One])) == Z Plus [One]
test003 = (add (Z Plus []) (Z Minus [One])) == Z Minus [One]

test011 = (add (Z Plus [Zero, One, One]) (Z Plus [One])) == Z Plus [One, One, One]
test012 = (add (Z Plus [Zero, One, One]) (Z Plus [Zero, One])) == Z Plus [Zero, Zero, Zero, One]
test013 = (add (Z Plus [Zero, One, One]) (Z Plus [Zero, One, One])) == Z Plus [Zero, Zero, One, One]

test021 = (add (Z Minus [Zero, One, One]) (Z Minus [One])) == Z Minus [One, One, One]
test022 = (add (Z Minus [Zero, One, One]) (Z Minus [Zero, One])) == Z Minus [Zero, Zero, Zero, One]
test023 = (add (Z Minus [Zero, One, One]) (Z Minus [Zero, One, One])) == Z Minus [Zero, Zero, One, One]

test031 = (add (Z Minus [Zero, One, One]) (Z Plus [One])) == Z Minus [One, Zero, One]
test032 = (add (Z Minus [Zero, One, One]) (Z Plus [Zero, One])) == Z Minus [Zero, Zero, One]
test033 = (add (Z Minus [Zero, One, One]) (Z Plus [Zero, One, One])) == Z Plus []

test041 = (add (Z Plus [Zero, One, One]) (Z Minus [One])) == Z Plus [One, Zero, One]
test042 = (add (Z Plus [Zero, One, One]) (Z Minus [Zero, One])) == Z Plus [Zero, Zero, One]
test043 = (add (Z Plus [Zero, One, One]) (Z Minus [Zero, One, One])) == Z Plus []

test051 = (add (Z Plus [One]) (Z Minus [One])) == Z Plus []
test052 = (add (Z Plus [One]) (Z Minus [One, One])) == Z Minus [Zero, One]
test053 = (add (Z Plus [One]) (Z Minus [Zero, One])) == Z Minus [One]
test054 = (add (Z Plus [One]) (Z Minus [Zero, Zero, Zero, One])) == Z Minus [One, One, One]
test055 = (add (Z Plus [One]) (Z Minus [Zero, One, Zero, One])) == Z Minus [One, Zero, Zero, One]
test056 = (add (Z Plus [Zero, One]) (Z Minus [Zero, One, One])) == Z Minus [Zero, Zero, One]
test057 = (add (Z Plus [Zero, One]) (Z Minus [Zero, Zero, One])) == Z Minus [Zero, One]
test058 = (add (Z Plus [One, Zero, One]) (Z Minus [Zero, One, Zero, One])) == Z Minus [One, Zero, One]


emptyZ  = Z Plus []

test101 = (mul (Z Plus []) (Z Plus [])) == emptyZ
test102 = (mul (Z Plus []) (Z Plus [One])) == emptyZ
test103 = (mul (Z Plus []) (Z Minus [One])) == emptyZ
test104 = (mul (Z Plus [One]) (Z Plus [])) == emptyZ
test105 = (mul (Z Minus [One]) (Z Plus [])) == emptyZ

test111 = (mul (Z Plus [One]) (Z Plus [One])) == Z Plus [One]
test112 = (mul (Z Minus [One]) (Z Plus [One])) == Z Minus [One]
test113 = (mul (Z Plus [One]) (Z Minus [One])) == Z Minus [One]
test114 = (mul (Z Minus [One]) (Z Minus [One])) == Z Plus [One]

test121 = (mul (Z Plus [One]) (Z Plus [Zero, One])) == Z Plus [Zero, One]
test122 = (mul (Z Plus [Zero, Zero, One]) (Z Plus [Zero, Zero, One])) == Z Plus [Zero, Zero, Zero, Zero, One]

test131 = (mul (Z Plus [One, Zero, One, Zero, One]) (Z Plus [One, One, One])) == Z Plus [One, One, Zero, Zero, One, Zero, Zero, One]


testAdd = test001 && test002 && test003 && test011 && test012 && test013 && test021 && test022 && test023 && test031 && test032 && test033 && test041 && test042 && test043 && test051 && test052 && test053 && test054 && test055 && test056 && test057 && test058
testMul = test101 && test102 && test103 && test104 && test105 && test111 && test112 && test113 && test114 && test121 && test122 && test131

testAll = testAdd && testMul


testList = [test001, test002, test003, test011, test012, test013, test021, test022, test023, test031, test032, test033, test041, test042, test043, test051, test052, test053, test054, test055, test056, test057, test058,test101, test102, test103, test104, test105, test111, test112, test113, test114, test121, test122, test131]

testIndices = [1,2,3,11,12,13,21,22,23,31,32,33,41,42,43,51,52,53,54,55,56,57,58,101,102,103,104,105,111,112,113,114,121,122,131]

allTests = zip testIndices testList

-- Список тестов с ошибками
badTests = map fst $ filter (not . snd) allTests
