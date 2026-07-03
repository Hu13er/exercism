module CollatzConjecture (collatz) where

collatz :: Integer -> Maybe Integer
collatz n
  | n < 1 = Nothing
  | n == 1 = Just 0
  | otherwise = fmap (+1) $ collatz nextN
  where
    isEven x = x `mod` 2 == 0
    nextN = if isEven n then (div n 2) else (n*3 + 1)

