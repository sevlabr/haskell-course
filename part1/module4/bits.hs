module Demo where


data Bit = Zero | One deriving(Show, Eq)
data Sign = Minus | Plus deriving(Show, Eq)
data Z = Z Sign [Bit] deriving(Show, Eq)

oneBitToDigit :: Bit -> Integer
oneBitToDigit Zero = 0
oneBitToDigit One  = 1

listBitsToDigits :: [Bit] -> [Integer]
listBitsToDigits bits = [oneBitToDigit bit | bit <- bits]

binToAbsDec :: [Integer] -> Integer
binToAbsDec bins = foldr (\x l -> x + 2 * l) 0 bins

absDecToDec :: Sign -> Integer -> Integer
absDecToDec Plus absVal = absVal
absDecToDec Minus absVal = (-1) * absVal

decToSignAbsDec :: Integer -> (Sign, Integer)
decToSignAbsDec dec | signum dec >= 0 = (Plus,  abs dec)
                    | otherwise       = (Minus, abs dec)

absDecToBin :: Integer -> [Integer]
absDecToBin 0      = []
absDecToBin absDec =
  let
    (q, r) = absDec `divMod` 2
  in
    r : absDecToBin q

oneDigitToBit :: Integer -> Bit
oneDigitToBit 0 = Zero
oneDigitToBit 1 = One
oneDigitToBit _ = error "Use only for 0s and 1s"

listDigitsToBits :: [Integer] -> [Bit]
listDigitsToBits digs = [oneDigitToBit dig | dig <- digs]

zToDec :: Z -> Integer
zToDec (Z sign bits) = absDecToDec sign (binToAbsDec (listBitsToDigits bits))

decToZ :: Integer -> Z
decToZ dec =
  let
    (sign, absDec) = decToSignAbsDec dec
    bits = listDigitsToBits $ absDecToBin absDec
  in
    Z sign bits

add :: Z -> Z -> Z
add z1 z2 = decToZ $ zToDec z1 + zToDec z2

mul :: Z -> Z -> Z
mul z1 z2 = decToZ $ zToDec z1 * zToDec z2


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
