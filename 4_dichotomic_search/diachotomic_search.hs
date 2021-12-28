module Main where

main :: IO ()
main = do
  putStrLn $ extract (search [1..1000] 1000)
  putStrLn $ extract (search [1..1000] 1001)
  putStrLn $ extract (search "abcde" 'e')
  putStrLn $ extract (search "abcde" 'f')


search :: Eq a => [a] -> a -> Maybe a
search [] _ = Nothing
search (x:xs) y
  | x == y = Just x
  | otherwise = search xs y

extract :: (Show a) => Maybe a -> String
extract Nothing = "null"
extract (Just x) = show x
