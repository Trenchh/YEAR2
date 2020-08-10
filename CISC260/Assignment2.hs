module Assignment2 where
--Author:Ryan Protheroe
--Date:February 7th, 2019

--QUESTION 1
showFormattedString :: [[Int]] -> IO()
showFormattedString listOfLists = putStrLn (getFormattedString listOfLists) --displays lists

getFormattedString :: [[Int]] -> String
getFormattedString [] = ""  -- empty case
getFormattedString (x : xs)
    | xs == [] = show x     --base case
    | otherwise = show x ++ "\n" ++ getFormattedString(xs)  -- recursive call


--QUESTION 2
parenthesesAreBalanced s = parenthesesAreBalancedHelper s 0 where
parenthesesAreBalancedHelper :: String -> Int -> Bool
parenthesesAreBalancedHelper "" count = (count == 0) --True
parenthesesAreBalancedHelper (x:xs) count
    | count < 0 = False    -- count should never reach < 0 if brackets are in correct order
    | x == '(' = parenthesesAreBalancedHelper xs (count+1)  -- counting bracket
    | x == ')' = parenthesesAreBalancedHelper xs (count-1)  -- found a pair of brackets
    | otherwise = parenthesesAreBalancedHelper xs count     -- if not bracket, move on to next char


--QUESTION 3
--declaring types
-- The User tuple is of the form (ID, Name)
type User = (Int, String)
-- The Content tuple is of the form (ID, Title)
type Content = (Int, String)
-- The Viewing tuple is of the form (User ID, Movie ID, Timestamp)
type Viewing = (Int, Int, Int)
-- The Rating tuple is of the form (User ID, Movie ID, Rating)
type Rating = (Int, Int, Int)


--QUESTION 3.1
averageRating :: Int -> Int
averageRating cID
    |cID < 0 = error "The content's ID number is negative"   --error
    |findRatings cID == [] = error "That content is not yet rated"  -- no ratings available
    |otherwise = div (addRatings listOfRatings) (length(listOfRatings)) --dividing rating total by length of rating list
    where
        listOfRatings = findRatings cID

findRatings :: Int -> [Int]
findRatings cID = [ rating | (uID, mID, rating) <- ratingData, mID == cID ] --returns list of ratings for specific movie
    where
        ratingData = [(4, 12, 5), (4, 15, 5), (4, 81, 5), (4, 37, 5), (4, 51, 2), (4, 43, 3), (4, 76, 5), (4, 29, 5), (4, 60, 3), (73, 51, 5), (73, 60, 4), (73, 43, 5), (34, 60, 1), (34, 15, 5)]

--Helper to add all values in "rating list" together
addRatings :: [Int] -> Int
addRatings (x:xs)
    |xs == [] = x   --returns "total rating"
    |otherwise = x + addRatings xs


--QUESTION 3.2
watchItAgain :: Int -> [Content]
watchItAgain uID
    |uID < 0 = error "The user's ID number is negative"  --error 
    |idsOfWatchedContent uID == [] = [] --empty case
    |otherwise = watchedContent (idsOfWatchedContent uID) --uses helpers to deduce list

--Helper to return the ID's of movies the user has watched
idsOfWatchedContent :: Int -> [Int]
idsOfWatchedContent uID = [ movieID | (userID, movieID, timestamp) <- viewingData, userID == uID ] 
    where
        viewingData = [(4, 12, 1516456852), (4, 15, 1537542147), (4, 81, 1504116489), (4, 37, 1541498412), (4, 51, 1508360754), (4, 76, 1516356148), (4, 29, 1536539720), (4, 60, 1508965289), (73, 51, 1517365941), (73, 60, 1516365257), (73, 43, 1536420631), (34, 60, 1507471645), (34, 15, 1509459643) ]

--Helper takes list of ID's and returns list of content that matches ID's
watchedContent :: [Int] -> [Content]
watchedContent (x:xs)
   |xs == [] = [ (movieID,title) | (movieID, title) <- contentData, movieID == x ] --base case
   |otherwise = [ (movieID,title) | (movieID, title) <- contentData, movieID == x ] ++ watchedContent xs --Appending list with recursion
    where
        contentData = [(12, "Dirk Gently's Holistic Detective Agency"), (15, "Black Panther"), (81, "Brooklyn 99"), (37, "The Good Place"), (51, "Iron Fist"), (43, "Solo"), (76, "The Vietnam War"), (29, "Secret City"), (60, "Ugly Delicious")]


--QUESTION 3.3
--Helper to return list of content with ratings >= 2
ratingGreaterThanTwo :: [Content]
ratingGreaterThanTwo = [ (movieID,title) | (movieID, title) <- contentData, (averageRating movieID) >= 2 ] 
    where
        contentData = [(12, "Dirk Gently's Holistic Detective Agency"), (15, "Black Panther"), (81, "Brooklyn 99"), (37, "The Good Place"), (51, "Iron Fist"), (43, "Solo"), (76, "The Vietnam War"), (29, "Secret City"), (60, "Ugly Delicious")]

suggestionsForYou :: Int -> [Content]
suggestionsForYou uID
    |uID < 0 = error "The user's ID number is negative" --error
    -- checks data to see if current movie has rating >= 2 and is not part of the list "watchItAgain"
    |otherwise = [ (movieID,title) | (movieID, title) <- contentData, elem (movieID,title) ratingGreaterThanTwo && notElem (movieID,title) (watchItAgain uID) ] 
    where
        contentData = [(12, "Dirk Gently's Holistic Detective Agency"), (15, "Black Panther"), (81, "Brooklyn 99"), (37, "The Good Place"), (51, "Iron Fist"), (43, "Solo"), (76, "The Vietnam War"), (29, "Secret City"), (60, "Ugly Delicious")]


