module PrintableClass where

class Printable a where
  toString :: a -> [Char]

instance Printable Bool where
  toString True  = "true"
  toString False = "false"

instance Printable () where
  toString () = "unit type"

instance (Printable a, Printable b) => Printable (a, b) where
  toString (x, y) = "(" ++ toString x ++ "," ++ toString y ++ ")"
