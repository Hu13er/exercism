module SumOfMultiples (sumOfMultiples) where
import qualified Data.List as List
import qualified Data.Set as Set

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit = 
    sum . Set.fromList . concat $ map (multipliers limit) factors

multipliers :: Integer -> Integer -> [Integer]
multipliers limit factor = takeWhile (<limit) $ map (*factor) [1..]
