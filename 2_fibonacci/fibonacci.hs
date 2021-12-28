module Main where

import Control.Monad ( forM_ ) 
import Control.Monad.Trans.State ( evalState, get, put )

main :: IO ()
main = do
  putStrLn "First 10 Fib numbers using ordinary recursion:"
  apply fibRec 30

  putStrLn "First 10 Fib numbers using tail recursion:"
  apply fibRec' 30

  putStrLn "First 10 Fib numbers using iteration, mutation, monads:"
  apply fibM 30

-- | Apply a function to number sequence counting down to 0
apply :: (Int -> Int) -> Int -> IO ()
apply f n
  | n == 0 = putStrLn $ show n ++ " : " ++ show (f n)
  | otherwise = do
    putStrLn $ show n ++ " : " ++ show (f n)
    apply f (n - 1)

-- | Simplest, recursive definition of Fibonacci numbers
-- | Slower than tail recursion since it's not unrolled by GHC
fibRec :: Int -> Int
fibRec n
  | n <= 1 = n
  | otherwise = fibRec (n - 1) + fibRec (n - 2)

-- | Tail-recursive definition of Fibonacci numbers.
-- | Unrolled by GHC into an iterative loop.
fibRec' :: Int -> Int
fibRec' n = iter n (0, 1)
  where
    iter num (a, b)
      | num == 0 = a
      | num == 1 = b
      | otherwise = iter (num - 1) (b, a + b)

-- | Iterative definition of Fibonacci numbers, using Monads to mutate state.
-- | Comparable to tail recursion, but not a pure function.
fibM :: Int -> Int
fibM n = flip evalState (0, 1) $ do
  forM_ [1..n] 
    $ \_ -> do
      (a, b) <- get
      put (b, a + b)
  (a, _) <- get
  return a

