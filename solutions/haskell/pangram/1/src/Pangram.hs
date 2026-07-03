module Pangram (isPangram) where

import Data.Char (toLower)
import Data.List (nub)

isPangram :: String -> Bool
isPangram text =
  length usedChars == 26
  where
    isEnglish c = c `elem` "abcdefghijklmnopqrstuvwxyz"
    usedChars = nub . filter isEnglish $ map toLower text
