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

-- retorna primeiros elementos da lista
primeiros :: [Int] -> [Int]
primeiros (h:t)
    | t == [] = []
    | otherwise = h : primeiros t

-- retorna valor em indice da lista
indice :: [Int] -> Int -> Int
indice (h:t) 0 = h
indice (h:t) n = indice t (n-1)

-- verifica se valor existe na lista
elemento :: [Int] -> Int -> Bool
elemento [] _ = False
elemento (h:t) n
    | h == n = True
    | otherwise = elemento t n

-- retorna tamanho da lista
tamanho :: [Int] -> Int
tamanho [] = 0
tamanho (h:t) = 1 + tamanho t

-- verifica se lista vazia
vazio :: [Int] -> Bool
vazio [] = True
vazio _ = False

-- retorna lista inversa
inverter :: [Int] -> [Int]
inverter [] = []
inverter (h:t) = inverter t ++ [h]

-- retorna n elementos da lista em outra lista
pegar :: [Int] -> Int -> [Int]
pegar [] _ = []
pegar (h:t) 0 = []
pegar (h:t) n = h : pegar t (n-1)

-- retorna lista com n primeiros elementos excluidos
vazar :: [Int] -> Int -> [Int]
vazar [] _ = []
vazar (h:t) 0 = (h:t)
vazar (h:t) n = vazar t (n-1)

-- retorna menor valor da lista
menorzin :: [Int] -> Int
menorzin (h:t) = menorzinAux t h

menorzinAux :: [Int] -> Int -> Int
menorzinAux [] l = l
menorzinAux (h:t) l
    | h < l = menorzinAux t h
    | otherwise = menorzinAux t l

-- retorna maior valor da lista
maiorzin :: [Int] -> Int
maiorzin (h:t) = maiorzinAux t h

maiorzinAux :: [Int] -> Int -> Int
maiorzinAux [] m = m
maiorzinAux (h:t) m
    | h > m = maiorzinAux t h
    | otherwise = maiorzinAux t m

-- retorna somatorio da lista
somador :: [Int] -> Int
somador [] = 0
somador (h:t) = h + somador t

-- retorna produto da lista
produto :: [Int] -> Int
produto [] = 1
produto (h:t) = h * produto t
