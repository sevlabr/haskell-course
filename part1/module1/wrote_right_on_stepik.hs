lenVec3 x y z = sqrt (x ^ 2 + y ^ 2 + z ^ 2)

sign x = if x > 0 then 1 else (if x < 0 then (-1) else 0)

-- {infixl 6 |-|}
x |-| y = abs(x - y)

logBase 4 $ min 20 $ 9 + 7 -- logBase 4 (min 20 (9 + 7))
