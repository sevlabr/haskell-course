module Demo where


data Point = Point Double Double

origin :: Point
origin = Point 0.0 0.0

distanceToOrigin :: Point -> Double
distanceToOrigin (Point x y) = sqrt (x ^ 2 + y ^ 2)

distance' :: Point -> Point -> Double
distance' (Point x1 y1) (Point x2 y2) = sqrt ((x2 - x1)^2 + (y2 - y1)^2)
-- distance' (Point x1 y1) (Point x2 y2) = distanceToOrigin (Point (x2-x1) (y2-y1))

-- *Demo> distance' (Point 3.1 4.5) (Point 0.6 (-0.9))
-- 5.950630218724736


data Shape = Circle Double | Rectangle Double Double

area :: Shape -> Double
area (Circle    r)   = pi * r^2
area (Rectangle a b) = a * b

square :: Double -> Shape
square a = Rectangle a a

isSquare :: Shape -> Bool
isSquare (Rectangle a b) = a == b
isSquare _               = False

-- using square function
-- isSquare rect@(Rectangle x y) = square x == rect

-- using Pattern Guards (another way for Pattern Matching)
-- isSquare rect
--     | (Rectangle a b) <- rect
--     = a == b
--     | _ <- rect
--     = False

-- https://wiki.haskell.org/Pattern_guard
isSquare' :: Shape -> Bool
isSquare' s | (Rectangle a b) <- s
            , a == b    = True
            | otherwise = False


data Coord a = Coord a a

distance :: Coord Double -> Coord Double -> Double
distance (Coord x1 y1) (Coord x2 y2) = sqrt $ (x2 - x1)^2 + (y2 - y1)^2

manhDistance :: Coord Int -> Coord Int -> Int
manhDistance (Coord x1 y1) (Coord x2 y2) = abs (x2 - x1) + abs (y2 - y1)


-- см. коммент на Степике, чтобы понять смысл задачи
-- getCenter 2.2 (Coord 2 1) = Coord 5.5 3.3
-- getCell 2.2 (Coord 3.2 1.6) = Coord 1 0

getCenter :: Double -> Coord Int -> Coord Double
getCenter s (Coord x y) =
  let
    xc = fromIntegral x * s + s / 2.0
    yc = fromIntegral y * s + s / 2.0
  in
    Coord xc yc

getCell :: Double -> Coord Double -> Coord Int
getCell s (Coord x y) =
  let
    xc = floor $ x / s
    yc = floor $ y / s
  in
    Coord xc yc
