module Demo where


data Board = Board Int Int Int Int Int Int Int Int Int

nextPositions :: Board -> [Board]
nextPositions (Board a b c e f g h i j) = undefined

-- Everything above is useless

nextPositionsN :: Board -> Int -> (Board -> Bool) -> [Board]
nextPositionsN b n pred | n <  0    = []
                        | n == 0    = filter pred [b]
                        | otherwise = filter pred $ do -- тут filter на самом деле не нужен, потому что он всегда будет отрабатывать строчкой выше
                            nextBoards  <- nextPositions b
                            otherBoards <- nextPositionsN nextBoards (n - 1) pred
                            return $ otherBoards
