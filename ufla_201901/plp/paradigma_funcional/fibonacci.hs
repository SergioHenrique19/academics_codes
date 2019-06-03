fib :: Integer -> Integer
fib n
    | n == 0 = 0
    | n == 1 = 1
    | n > 1 = fib (n - 2) + fib (n - 1)
    | otherwise = error "indefinido..."

main = do
    putStr "Fibonacci: "
    n <- readLn
    print (fib n)
