module DNA (toRNA) where

toRNA :: String -> Either Char String
toRNA xs = 
  foldl folder (Right "") xs
  where
    folder (Left c)    _ = Left c
    folder (Right acc) x = 
      (\c -> acc ++ [c]) <$> (case x of
        'G' -> Right 'C'
        'C' -> Right 'G'
        'T' -> Right 'A'
        'A' -> Right 'U'
        r   -> Left r)



