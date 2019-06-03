fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib n = fib (n - 2) + fib (n - 1)

main = do
    putStr "Fibonacci: "
    n <- readLn
    print (fib n)
