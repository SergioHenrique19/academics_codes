-- somador
soma :: Integer -> Integer
soma 1 = 1
soma n = soma(n - 1) + n

-- fatorial
fatorial :: Integer -> Integer
fatorial 0 = 1
fatorial n = fatorial(n - 1) * n

-- fibonacci
fibonacci :: Integer -> Integer
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci(n - 1) + fibonacci(n - 2)

-- exemplo com variaveis anonimas
op_and :: Bool -> Bool -> Bool
op_and False _ = False
op_and _ False = False
op_and True True = True