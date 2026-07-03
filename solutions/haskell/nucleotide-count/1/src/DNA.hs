module DNA (nucleotideCounts, Nucleotide(..)) where

import qualified Data.Map as Map

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

nucleotideCounts :: String -> Either String (Map.Map Nucleotide Int)
nucleotideCounts xs = 
    nucleotideCounts' $ map nucleotideFrom xs

nucleotideCounts' :: [Maybe Nucleotide] -> Either String (Map.Map Nucleotide Int)
nucleotideCounts' []           = Right nucleotideEmpty
nucleotideCounts' (Nothing:_)  = Left "error"
nucleotideCounts' (Just n:xs)  =
    Map.update (\x -> Just $ x+1) n <$> nucleotideCounts' xs

nucleotideEmpty :: Map.Map Nucleotide Int
nucleotideEmpty = Map.fromList . zip [A, C, G, T] $ repeat 0

nucleotideFrom :: Char -> Maybe Nucleotide
nucleotideFrom 'A' = Just A
nucleotideFrom 'C' = Just C
nucleotideFrom 'G' = Just G
nucleotideFrom 'T' = Just T
nucleotideFrom _   = Nothing


