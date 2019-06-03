fat :: Integer -> Integer
fat n
    | n == 0 = 1
    | n > 0 = n * fat (n - 1)
    | otherwise = error "indefinido..."

main = do
    putStr "Fatorial: "
    n <- readLn
    print (fat n)
