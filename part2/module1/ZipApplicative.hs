module Demo where


import Data.List (zipWith, zipWith3, zipWith4)
import Control.Applicative (ZipList(ZipList), getZipList)

x1s = [1,2,3]
x2s = [4,5,6]
x3s = [7,8,9]
x4s = [10,11,12]

listZips :: IO ()
listZips = mapM_ print [zipWith  (\a b     -> 2 * a + 3 * b)                 x1s x2s,
                        zipWith3 (\a b c   -> 2 * a + 3 * b + 5 * c)         x1s x2s x3s,
                        zipWith4 (\a b c d -> 2 * a + 3 * b + 5 * c - 4 * d) x1s x2s x3s x4s]

listApplicativeZips :: IO ()
listApplicativeZips = mapM_ print [getZipList $ (\a b     -> 2 * a + 3 * b)                 <$> ZipList x1s <*> ZipList x2s,
                                   getZipList $ (\a b c   -> 2 * a + 3 * b + 5 * c)         <$> ZipList x1s <*> ZipList x2s <*> ZipList x3s,
                                   getZipList $ (\a b c d -> 2 * a + 3 * b + 5 * c - 4 * d) <$> ZipList x1s <*> ZipList x2s <*>ZipList x3s <*> ZipList x4s]

(>*<) :: [a -> b] -> [a] -> [b]
fs >*< as = getZipList $ ZipList fs <*> ZipList as

(>$<) :: (a -> b) -> [a] -> [b]
f >$< as = getZipList $ f <$> ZipList as

listAdvancedApplicativeZips :: IO ()
listAdvancedApplicativeZips = mapM_ print [(\a b     -> 2 * a + 3 * b)                 >$< x1s >*< x2s,
                                           (\a b c   -> 2 * a + 3 * b + 5 * c)         >$< x1s >*< x2s >*< x3s,
                                           (\a b c d -> 2 * a + 3 * b + 5 * c - 4 * d) >$< x1s >*< x2s >*< x3s >*< x4s]
