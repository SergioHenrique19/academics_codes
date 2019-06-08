lista = [4,2,5,1,3]

main = do
    print $ head lista  -- cabeca da lista
    print $ tail lista  -- cauda da lista
    print $ last lista  -- ultimo elemento da lista
    print $ init lista  -- primeiros elemento da lista
    print $ lista !! 1  -- index da lista
    print $ elem 4 lista  -- verifica valor na lista
    print $ length lista  -- tamanho da lista
    print $ null lista  -- lista vazia
    print $ reverse lista  -- imprime inverso da lista
    print $ take 3 lista  -- retorna n primeiros elementos da lista
    print $ drop 3 lista  -- retorna lista sem n primeiros elementos da lista
    print $ minimum lista  -- menor valor da lista
    print $ maximum lista  -- maior valor da lista
    print $ sum lista  -- soma elementos da lista
    print $ product lista  -- produto da lista

-- retorna cabeca da lista
cabeca :: [Int] -> Int
cabeca (h:t) = h

-- retorna cauda da lista
cauda :: [Int] -> [Int]
cauda (h:t) = t

-- retorna ultimo elemento da lista
ultimo :: [Int] -> Int
ultimo (h:t)
    | length (h:t) == 1 = h
    | otherwise = ultimo t