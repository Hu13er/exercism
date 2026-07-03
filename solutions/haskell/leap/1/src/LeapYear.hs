module LeapYear (isLeapYear) where

isLeapYear :: Integer -> Bool
isLeapYear year
          | isDivisable year 400 = True
          | isDivisable year 100 = False
          | isDivisable year 4 = True
          | otherwise = False

isDivisable :: Integer -> Integer -> Bool
isDivisable year to = year `mod` to == 0

