module Main where

import Control.Monad ( forM_ ) 
import Control.Monad.Trans.State ( evalState, get, put )

main :: IO ()
main = do
  print $ factorial 5
  print $ factorial' 5
  print $ factorial'' 5


-- | Factorial -- using recursion
factorial :: Integer -> Integer
factorial n
  | n < 0 = error "No factorial for negative numbers"
  | n == 0 = 1
  | otherwise = n * factorial (n - 1)
  

-- Factorial -- using tail recursion
factorial' :: Integer -> Integer
factorial' n =
  iter n 1 where
    iter :: Integer -> Integer -> Integer
    iter n acc
      | n <= 0 = acc
      | otherwise = iter (n - 1) (n * acc)


-- | factorial using Monads
factorial'' :: Integer -> Integer
factorial'' n = flip evalState 1 $ do
  forM_ [1..n] $ \i -> do
    x <- get
    put $ x * i
  get
