module Demo where


import System.Directory
import Data.List

printDelFunc :: String -> String -> IO ()
printDelFunc substr =
  \fileName ->
    if isInfixOf substr fileName
      then do
        putStrLn $ "Removing file: " ++ fileName
        removeFile fileName
      else return ()

main' :: IO ()
main' = do
  putStr "Substring: "
  substr <- getLine
  if substr == ""
    then putStrLn "Canceled"
    else do
      files <- getDirectoryContents "."
      mapM_ (printDelFunc substr) files
