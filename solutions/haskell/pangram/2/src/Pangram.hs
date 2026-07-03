module Pangram (isPangram) where

import Data.Char (toLower)
import Data.List (nub)

isPangram :: String -> Bool
isPangram text =
  length (nub letters) == 26
  where
    isEnglish c = c `elem` ['a' .. 'z']
    letters = filter isEnglish $ map toLower text
