module Demo where


data Point = Point Double Double

origin :: Point
origin = Point 0.0 0.0

distanceToOrigin :: Point -> Double
distanceToOrigin (Point x y) = sqrt (x ^ 2 + y ^ 2)

distance :: Point -> Point -> Double
distance (Point x1 y1) (Point x2 y2) = sqrt ((x2 - x1)^2 + (y2 - y1)^2)

-- *Demo> distance (Point 3.1 4.5) (Point 0.6 (-0.9))
-- 5.950630218724736


data Shape = Circle Double | Rectangle Double Double

area :: Shape -> Double
area (Circle    r)   = pi * r^2
area (Rectangle a b) = a * b