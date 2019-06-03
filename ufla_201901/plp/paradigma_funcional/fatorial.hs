fac :: Integer -> Integer
fac 0 = 1
fac n = n * fac (n - 1)

main = do
    putStr "Fatorial: "
    n <- readLn
    print (fac n)
