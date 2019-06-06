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
-- questao 3 [fim]

-- questao 4 [inicio]
mmc::Int->Int->Int
mmc a b
    | b == a = a
    | otherwise = div (a * b) (mdc a b)
-- questao 4 [fim]

-- questao 5 [inicio]
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
import Data.List
mdcLista a = sort a
-- questao 7 [fim]

-- questao 8 [inicio]
-- questao 8 [fim]

-- questao 5 [inicio]
-- questao 5 [fim]