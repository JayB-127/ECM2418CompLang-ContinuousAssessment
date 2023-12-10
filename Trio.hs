import Data.List

main :: IO()
main
    = print(generator2)

-- generates all possible numbers (N1 to N5)
generator2 :: [(String, String, String, String, String)]
generator2
    = [(n1, n2, n3, n4, n5)
    | n1 <- map show [123..987], noDups(toDigits(read n1)), noZero(n1)
    , n3 <- permutations n1, noDups(toDigits(read n3))
    , n5 <-  permutations n1, noDups(toDigits(read n5))
    , sum(map read [n1, n3, n5]) < 2000
    , n2 <- map show [12..98], digitsIn n1 n2, noDups(toDigits(read n2))
    , n4 <- map show [12..98], digitsIn n1 n4, noDups(toDigits(read n4))
    , notFirstDigits n1 n2
    ]
    
-- checks for duplicate digits
noDups :: Eq a => [a] -> Bool
noDups s
    = s == nub s
    
-- converts an int to a list of its digits
toDigits :: Int -> [Int]
toDigits 0
    = []
toDigits x
    = toDigits(x `div` 10) ++ [x `mod` 10]

-- checks for '0' in string
noZero :: String -> Bool
noZero s
    = not ('0' `elem` s)
    
-- checks 'digits' in string are in another
digitsIn :: String -> String -> Bool
digitsIn xs []
    = True
digitsIn xs [y1, y2]
    = y1 `elem` xs && y2 `elem` xs
    
-- compares first 'digits' of strings, ensuring they are different
notFirstDigits :: String -> String -> Bool
notFirstDigits xs ys
    = not (head xs == head ys)
    
    
    