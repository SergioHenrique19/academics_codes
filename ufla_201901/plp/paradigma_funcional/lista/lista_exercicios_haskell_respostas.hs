-- questao 1 [inicio]
baskara :: Float -> Float -> Float -> (Float, Float)
baskara a b c =
        let delta = sqrt (b^2 - 4*a*c)
        in ((-b-delta)/(2*a), (-b+delta)/(2*a))
-- questao 1 [fim]

-- questao 2 [inicio]
maiorMedia :: Int -> Int -> Int -> Int
maiorMedia a b c
    | media < a || media < b || media < c = 1
    | otherwise = 0
    where
    media = (a + b + c) `div` 3
-- questao 2 [fim]