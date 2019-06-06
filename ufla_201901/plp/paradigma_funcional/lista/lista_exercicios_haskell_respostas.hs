{- GCC198 (2019/1) - Paradigma Funcional - Respostas da lista de exercicios
   Sérgio H. M. Garcia -}

-- questao 1 [inicio]
baskara :: Float -> Float -> Float -> (Float, Float)
baskara a b c =
        let delta = sqrt (b^2 - 4*a*c)
        in ((-b-delta)/(2*a), (-b+delta)/(2*a))
-- questao 1 [fim]

-- questao 2 [inicio]
maiorMedia :: Int -> Int -> Int -> Int
maiorMedia a b c
    | media < a && media < b = 2
    | media < a && media < c = 2
    | media < b && media < c = 2
    | media < a || media < b || media < c = 1
    | otherwise = 0
    where media = (a + b + c) `div` 3
-- questao 2 [fim]

-- questao 3 [inicio]
somaIntervalo :: Int -> Int -> (Int, Int)
somaIntervalo a b = ((sum [x | x <- [a .. b]]), (sum [x | x <- [(a+1) .. (b-1)]]))
-- questao 3 [fim]

-- questao 4 [inicio]
mmc::Int -> Int -> Int
mmc a b
    | b == a = a
    | otherwise = div (a * b) (mdc a b)
-- questao 4 [fim]

-- questao 5 [inicio]
mmcLista :: [Int] -> Int
mmcLista [] = error "Lista vazia"
mmcLista (h:t)
    | t == [] = h
    | otherwise = mmc h (mmcLista t)
-- questao 5 [fim]

-- questao 6 [inicio]
mdc :: Int -> Int -> Int
mdc a b
    | mod a b == 0 = b
    | mod b a == 0 = a
    | a > b = mdc b (mod a b)
    | a < b = mdc a (mod b a)
-- questao 6 [fim]

-- questao 7 [inicio]
mdcLista :: [Int] -> Int
mdcLista (h:t)
    | t == [] = h
    | otherwise = mdcLista (mdcLista_aux h t)

mdcLista_aux :: Int -> [Int] -> [Int]
mdcLista_aux x [] = []
mdcLista_aux x (h:t)
    | mod x h == 0 = (h:t)
    | otherwise = mdcLista_aux h ((mod x h):t)
-- questao 7 [fim]

-- questao 8 [inicio]
produtoIntervalo :: Int -> Int -> Int
produtoIntervalo a b = product [x | x <- [a .. b]]
-- questao 8 [fim]

-- questao 9 [inicio]
raizInteira :: Int -> Int
raizInteira n = maximum [x|x <- [1 .. n], x*x <= n]
-- questao 9 [fim]

-- questao 10 [inicio]
unirListas :: [Int] -> [Int] -> [Int]
unirListas (h:t) b
    | t == [] = h : b
    | otherwise = h : unirListas t b
-- questao 10 [fim]

-- questao 11 [inicio]
removerEspacos :: String -> String
removerEspacos [] = ""
removerEspacos (h:t)
    | h == ' ' = h : removerEspacos(removerEspacos_aux t)
    | otherwise = h : removerEspacos t

removerEspacos_aux :: String -> String
removerEspacos_aux (h:t)
    | h == ' ' = removerEspacos_aux t
    | otherwise = h:t
-- questao 11 [fim]

-- questao 12 [inicio]
-- questao 12 [fim]

-- questao 13 [inicio]
-- questao 13 [fim]

-- questao 14 [inicio]
-- questao 14 [fim]

-- questao 15 [inicio]
-- questao 15 [fim]

-- questao 16 [inicio]
-- questao 16 [fim]

-- questao 17 [inicio]
-- questao 17 [fim]

-- questao 18 [inicio]
-- questao 18 [fim]
