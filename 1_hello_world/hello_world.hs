module Main where

main :: IO ()
main = do

  -- print str, sans newline
  putStr "Hello, World."

  -- add space
  putChar ' '

  -- create a variable, print with newline
  let message = "Hello World"
  putStrLn message



