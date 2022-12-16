module Demo where


main'' = do
  putStrLn "What is your name?"
  name <- getLine
  putStrLn $ "Nice to meet you, " ++ name ++ "!"

main' :: IO ()
main' = do
  putStr "What is your name?\nName: "
  name <- getLine
  if name == "" then main' else putStr $ "Hi, " ++ name ++ "!\n"
