module LogLevel where


-- GHCi> cmp Error Warning
-- GT
-- GHCi> cmp Info Warning
-- LT
-- GHCi> cmp Warning Warning
-- EQ

-- data LogLevel = Error | Warning | Info deriving(Eq, Ord)

-- cmp :: LogLevel -> LogLevel -> Ordering
-- cmp l r | l < r  = GT
--         | l > r  = LT
--         | l == r = EQ

data LogLevel = Error | Warning | Info

cmp :: LogLevel -> LogLevel -> Ordering
cmp Error   Error   = EQ
cmp Warning Warning = EQ
cmp Info    Info    = EQ
cmp Error   _       = GT
cmp Info    _       = LT
cmp Warning Error   = LT
cmp Warning Info    = GT

-- cmp Error   Error   = EQ
-- cmp Warning Warning = EQ
-- cmp Info    Info    = EQ
-- cmp Error   _       = GT
-- cmp Warning Info    = GT
-- cmp _       _       = LT

-- cmp :: LogLevel -> LogLevel -> Ordering
-- cmp x y = compare (ord x) (ord y) where
--    ord Error   = 3
--    ord Warning = 2
--    ord Info    = 1
