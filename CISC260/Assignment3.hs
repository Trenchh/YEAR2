module Assignment3 where
--Author:Ryan Protheroe
--Date:March 6th, 2019

--Part 1
--Question 1.1

--creating Item
data Item = 
    -- PhysicalItem: id, name, price, stock
    PhysicalItem Int String Float Int | 
    -- DigitalDownload: id, name, price, file
    DigitalDownload Int String Float String

--type synonym for list of Item
type Inventory = [Item]

--Show for Items
instance Show Item where
    show (PhysicalItem id name price stock) =
        "\n" ++ name ++ " (" ++ (show id) ++ ")\n$" ++ show price ++ "\n" ++ show stock ++ " in stock" ++ "\n"
    show (DigitalDownload id name price file) =
        "\n" ++ name ++ " (" ++ (show id) ++ ")\n$" ++ show price ++ "\n" ++ "Link: " ++ file ++ "\n"

--returns ID of any Item, used in part 3
getID :: Item -> Int
getID (PhysicalItem id _ _ _) = id
getID (DigitalDownload id _ _ _) = id

--returns price of any Item, used in part 3
getPrice :: Item -> Float
getPrice (PhysicalItem _ _ price _) = price
getPrice (DigitalDownload _ _ price _) = price

--dataset given on assignment page
smallTShirt = PhysicalItem 3 "Small T-shirt" 19.99 2
mediumTShirt = PhysicalItem 5 "Medium T-shirt" 19.99 10
largeTShirt = PhysicalItem 7 "Large T-shirt" 19.99 3
track1 = DigitalDownload 9 "Track 1" 0.99 "/track-1"
track2 = DigitalDownload 10 "Track 2" 0.99 "/track-2"
track3 = DigitalDownload 11 "Track 3" 0.99 "/track-3"
track4 = DigitalDownload 14 "Track 4" 0.99 "/track-4"

--given on assignment page, used to call "inventory"
inventory :: Inventory
inventory = [smallTShirt, mediumTShirt, largeTShirt, track1, track2, track3, track4]

--Question 1.2
-- creating Order: id, date, purchased
data Order = Order Int String [Int]

--type synonym for list of Orders
type Sales = [Order]

--Show for Order
instance Show Order where
    show (Order id date purchased) =
        "\n" ++ show id ++ " (" ++ date ++ ")\nPurchased: " ++ show purchased ++ "\n"

--dataset given on assignment page
order101 = Order 101 "01/01/2019" [3,7]
order104 = Order 104 "10/01/2019" [9,10,11]
order105 = Order 105 "12/02/2019" [5]
order109 = Order 109 "25/02/2019" [9,10,11,14]

--given on assignment page, used to call "sales"
sales :: Sales
sales = [order101, order104, order105, order109]

--Part 2
--Uses mapM_ to apply "show" to each element without returning another list
displayList :: (Show a) => [a] -> IO() 
displayList [] = error "Empty List."    --empty list case
displayList list = mapM_ (\n-> putStr(show n)) list

--Part 3
--Question 3.1
calculateTotal :: Order -> Inventory -> Float
calculateTotal _ [] = error "Empty Inventory."    --empty list case
calculateTotal (Order _ _ purchased) stock = sum (map getPrice items)
    where     --filters out items not purchased, maps price to each item bought and sums list
        items = filter (\x -> ( elem (getID x) purchased)) stock

--Question 3.2
-- maps payPal fee of each order to order list, sums list to get total and rounds to two decimals
payPalFees :: Sales -> Inventory -> Float
payPalFees _ [] = error "Empty Inventory."    --empty list case
payPalFees [] _ = error "Empty Sales List."    --empty list case
payPalFees orders stock = roundCurrency(sum (map (\x -> ((calculateTotal x stock) * 0.029) + 0.3) orders))

--Given on assignment page to round currency
roundCurrency :: Float -> Float
roundCurrency c = (fromIntegral (round (c * 100))) / 100