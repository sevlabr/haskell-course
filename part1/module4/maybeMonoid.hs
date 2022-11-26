module Demo where


newtype Maybe' a = Maybe' { getMaybe :: Maybe a }
  deriving (Eq,Show)

instance Monoid a => Semigroup (Maybe' a) where
  x              <> Maybe' Nothing = Maybe' Nothing
  Maybe' Nothing <> y              = Maybe' Nothing
  Maybe' x <> Maybe' y = Maybe' (x <> y)

instance Monoid a => Monoid (Maybe' a) where
  mempty = Maybe' $ Just mempty
