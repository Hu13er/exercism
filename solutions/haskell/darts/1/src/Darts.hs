module Darts (score) where

score :: Float -> Float -> Int
score x y
  | d <= dist 1 = 10
  | d <= dist 5 = 5
  | d <= dist 10 = 1
  | otherwise = 0
  where
    d = dist2 x y

dist2 :: Float -> Float -> Float
dist2 x y = x * x + y * y

dist :: Float -> Float
dist = dist2 0
