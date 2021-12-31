module Main where

main :: IO ()
main = do
  text <- readFile "./data.txt"
  let _lines = lines text
      firstLine = head _lines
      lastLine = last _lines
      output = firstLine ++ "\n" ++ lastLine
  writeFile "write_hs.txt" output
  

  -- print $ head _lines
  -- print $ last _lines
