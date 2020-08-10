module Assignment1 where
--Author:Ryan Protheroe

--accumulator works as c in 2^c for calculating decimal equivalent of binary
convertFromBinary n = convertFromBinaryHelper n 0 where
convertFromBinaryHelper :: Int -> Int -> Int
convertFromBinaryHelper n c
    | n < 0 = error "None of the parameters can be negative"
    | mod n 10 > 1 = error "All of the digits must be 0s or 1s"
    | n == 1 = (2^c)	--base case
    | n == 0 = 0		--base case
    | mod n 10 == 0 = convertFromBinaryHelper (div n 10) (c+1)	--removes rightmost value, c increases
    | mod n 10 == 1 = (2^c) + convertFromBinaryHelper (div n 10) (c+1) 	--adds value, removes rightmost value, c increases

countStepsInBinarySearch :: Int -> Int -> Int
countStepsInBinarySearch search upper
    | search < 0 || upper < 0 = error "None of the parameters can be negative"
    | search > upper || search == 0 = error "The value is not in range"
    | (div upper 2) == search = 1		--base case/found search value
    | upper == 1 && search == 1 = 1		--base case for reduction
    | search < (div upper 2) = 1 + countStepsInBinarySearch search (div upper 2)	--lower half of search margin
    | search > (div upper 2) = 1 + countStepsInBinarySearch (div search 2) (div upper 2)	--halving search and upper deduces into another binary search pattern,
    																						--upper half of search margin

countNestedForwards limit = countNestedForwardsHelper limit 0 0 0 where
countNestedForwardsHelper :: Int -> Int -> Int -> Int -> Int
countNestedForwardsHelper limit count i j
    | limit < 0 = error "None of the parameters can be negative"
    | i >= limit = count 	--end of loop/returns count
    | j >= limit = countNestedForwardsHelper limit count (i+1) (i+1)	--set j=i, increase i
    | otherwise = countNestedForwardsHelper limit (count+1) i (j+1)		--increase count and j

-- binaryLength :: Float -> Float
-- binaryLength n
--     | n == 0 = 0
--     | n < 2 = 1.0
--     | otherwise = 1.0 + (binaryLength(n/10))
