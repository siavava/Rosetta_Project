module Main where

import Control.Monad ( forM_ )
import Data.Bits ( shiftL )

-- To simplify
type State = Integer
type Moves = [Integer]
type MaxStatus = Bool

infinity :: Integer
infinity = 1 `shiftL` 200

negInfinity :: Integer
negInfinity = negate infinity

main :: IO ()
main = do
  let moves = [2, 3, 5]
  let startStates = [1..7] ++ [10]
  forM_ startStates $ \startState -> do        -- for each state in states as "startState"...
    let outcome = solve startState moves
    putStrLn $ show startState ++ ": " ++ display outcome

maximize :: State -> Moves -> State
maximize state moves =
  let maxStatus = True
  in check state moves maxStatus negInfinity

minimize :: State -> Moves -> State
minimize state moves = 
  let maxStatus = False
  in check state moves maxStatus infinity

check :: State -> Moves -> MaxStatus -> State -> State
check state allMoves maxStatus acc
  | state == 0 || null allMoves = acc
  | otherwise = let
      move = head allMoves
      nextState = state - move
      isValid = nextState >= 0
      nextMoves = tail allMoves
    in 
      if isValid then let
        nextAcc
          | maxStatus = max acc ( minimize nextState allMoves )
          | otherwise =  min acc ( maximize nextState allMoves )
        in check state nextMoves maxStatus nextAcc
      else 
        check state nextMoves maxStatus acc


solve :: State -> Moves -> State
solve = maximize

display :: State -> String
display n
  | n > 0       =   "First"     ++ " (value = " ++ show n ++ ")"
  | n < 0       =   "Second"    ++ " (value = " ++ show n ++ ")"
  | otherwise   =   "Draw"      ++ " (value = " ++ show n ++ ")"
