module Demo where


data Point3D a = Point3D a a a deriving Show

data GeomPrimitive a = Point (Point3D a) | LineSegment (Point3D a) (Point3D a)
  deriving Show

-- GHCi> fmap (+ 1) $ Point (Point3D 0 0 0)
-- Point (Point3D 1 1 1)

-- GHCi> fmap (+ 1) $ LineSegment (Point3D 0 0 0) (Point3D 1 1 1)
-- LineSegment (Point3D 1 1 1) (Point3D 2 2 2)

instance Functor Point3D where
  fmap f (Point3D x y z) = Point3D (f x) (f y) (f z)

instance Functor GeomPrimitive where
  fmap f (Point p) = Point $ fmap f p
  fmap f (LineSegment p1 p2) = LineSegment (fmap f p1) (fmap f p2)

--- Tests ---
testPoint = fmap (+ 1) $ Point (Point3D 0 0 0)
testLineSegment = fmap (+ 1) $ LineSegment (Point3D 0 0 0) (Point3D 1 1 1)
