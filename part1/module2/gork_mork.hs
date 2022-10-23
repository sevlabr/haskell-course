module GorkMork where


class KnownToGork a where
    stomp :: a -> a
    doesEnrageGork :: a -> Bool

class KnownToMork a where
    stab :: a -> a
    doesEnrageMork :: a -> Bool

class (KnownToGork a, KnownToMork a) => KnownToGorkAndMork a where
    stompOrStab :: a -> a
    stompOrStab val | doesEnrageMork val && doesEnrageGork val = stomp (stab val)
                    | doesEnrageGork val                       = stab val
                    | doesEnrageMork val                       = stomp val
                    | otherwise                                = val
