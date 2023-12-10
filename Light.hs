import Data.List
import Data.Char

main :: IO()
main
    = print (filter tester1 generator1)
    
-- generates all clock displays
generator1 :: [(Int, Int, Int, Int)]
generator1
    = [(hr, mn, dy, mt)
    | mt <- [1..12]
    , dy <- [1..31]
    , hr <- [0..23]
    , mn <- [0..59]
    , dayLimit dy mt
    ]

-- limits dy value depending on month (i.e., only 28 days in feb)
dayLimit :: Int -> Int -> Bool
dayLimit dy mt
    | mt == 2 && dy > 28 = False
    | mt `elem` [4, 6, 9, 11] && dy > 30 = False
    | mt `elem` [1, 3, 5, 7, 8, 10, 12] && dy > 31 = False
    | otherwise = True

  
-- checks for duplicate digits within of all digits in date (including 0s)
nodups :: [Int] -> Bool
nodups xs
    | list == nub list = True
    | otherwise = False
    where
        list = join xs
    
-- checks if an int is prime
prime :: Int -> Bool
prime
    = not . factorisable 2
    
-- checks if x is a factor of y
factorisable :: Int -> Int -> Bool
factorisable x y
    | x * x <= y = y `mod` x == 0 || factorisable (x+1) y
    | otherwise = False
    
-- increments mn component
incMin :: (Int, Int, Int, Int) -> (Int, Int, Int, Int)
incMin (hr, mn, dy, mt)
    | mn /= 59 = (hr, mn + 1, dy, mt)
    | otherwise = incHour (hr, 0, dy, mt)

-- increments hr component
incHour :: (Int, Int, Int, Int) -> (Int, Int, Int, Int)
incHour (hr, mn, dy, mt)
    | hr /= 23 = (hr + 1, mn, dy, mt)
    | otherwise = incDay (0, mn, dy, mt)

-- incremements dy component
incDay :: (Int, Int, Int, Int) -> (Int, Int, Int, Int)
incDay (hr, mn, dy, mt)
    = (hr, mn, dy + 1, mt)

-- incremements mt component
incMonth :: (Int, Int, Int, Int) -> (Int, Int, Int, Int)
incMonth (hr, mn, dy, mt)
    = (hr, mn, dy, mt + 1)

-- generates list of segment values of each digit
litSegments :: [Int] -> [Int]
litSegments []
    = []
litSegments (x:xs)
    | x == 0 || x == 6 || x == 9 = 6 : litSegments xs
    | x == 1 = 2 : litSegments xs
    | x == 2 || x == 3 || x == 5 = 5 : litSegments xs
    | x == 4 = 4 : litSegments xs
    | x == 7 = 3 : litSegments xs
    | x == 8 = 7 : litSegments xs
    
-- sums up a list of ints
sumList :: [Int] -> Int
sumList []
    = 0
sumList (x:xs)
    = x + sumList xs
   
-- converts a list of ints to a string 
join :: [Int] -> [Char]
join []
    = ""
join xs
    = intercalate "" (map show xs)
    
-- separates all digits into a list and pads with required 0s
padZero :: [Int] -> [Int]
padZero xs
    = drop (length list - 4) (0 : 0 : 0 : 0 : list)
    where
        list = map digitToInt (join xs)

-- calculates the sum of lit segments in a display
numLitSegments :: (Int, Int, Int, Int) -> Int
numLitSegments (hr, mn, dy, mt)
    = sumList (litSegments (padZero [hr, mn, dy, mt]))

-- checks if a tuple of ints is "magic"
magic :: (Int, Int, Int, Int) -> Bool
magic (hr, mn, dy, mt)
    = nodups (padZero [hr, mn, dy, mt])
    && prime (numLitSegments (hr, mn, dy, mt))
    
--TODO: floating point
average :: [Int] -> Int
average xs
    = (sumList xs) `div` 2
    
-- finds clock displays that fit the requirements
tester1 :: (Int, Int, Int, Int) -> Bool
tester1 (hr, mn, dy, mt)
    = magic (hr, mn, dy, mt)
    && magic (nextDay)
    && numLitSegments (incMin nextDay) == average [numLitSegments (hr, mn, dy, mt), numLitSegments (nextDay)]
    where
        nextDay = incDay (hr, mn, dy, mt)
        
x_generator1 :: Int
x_generator1 =
    length [ t | t <- ts , t `elem` g ]
    where
        g = generator1
        ts =
            [ ( 2 ,15 ,14 ,11)
            , ( 4 ,31 ,27 , 9)
            , ( 6 ,47 ,10 , 8)
            , ( 9 , 3 ,23 , 6)
            , (11 ,19 , 6 , 5)
            , (13 ,35 ,19 , 3)
            , (15 ,51 , 2 , 2)
            , (18 , 6 ,16 ,12)
            , (20 ,22 ,29 ,10)
            , (22 ,38 ,11 , 9)
            ]
        
x_tester1 :: Int
x_tester1 =
    length [ t | t <- ts , tester1 t ]
    where
        ts =
            [ ( 6 ,59 ,17 ,24)
            , ( 6 ,59 ,17 ,34)
            , ( 6 ,59 ,27 ,14)
            , ( 6 ,59 ,27 ,41)
            , ( 8 ,59 ,12 ,46)
            , (16 ,59 , 7 ,24)
            , (16 ,59 , 7 ,42)
            , (16 ,59 , 7 ,43)
            , (16 ,59 ,27 ,40)
            , (18 ,59 , 2, 46)
            ]