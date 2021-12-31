module Main where

-- Haskell is a Compiled language;
-- To run, install GHC and either run ghci or run ghc --make <filename> then run compiled binary.

main :: IO ()
main = do
  text <- readFile "./data.txt"
  let _lines = lines text
  writeFile "write_hs.txt" $ head _lines
  appendFile "write_hs.txt" "\n\n"
  appendFile "write_hs.txt" $ last _lines
