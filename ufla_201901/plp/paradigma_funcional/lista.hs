-- funcao que retorna tamanho da lista
size_list [] = 0
size_list (a:b) = 1 + size_list b

-- funcao que soma elementos da lista
sum_list [] = 0
sum_list (a:b) = a + sum_list b

-- funcao que verifica se duas listas sao iguais
listas_iguais :: [Int] -> [Int] -> Bool
listas_iguais [] [] = True
listas_iguais [] _ = False
listas_iguais _ [] = False
listas_iguais (a:b) (c:d)
    | (a == c) = listas_iguais b d
    | otherwise = False

-- funcao que retorna o inverso da lista (!otimizado)
inver_aux :: [t] -> [t] -> [t]
inver_aux [] l_inver = l_inver
inver_aux (a:b) l_inver = inver_aux b l_inver++[a]

inver_lista :: [t] -> [t]
inver_lista [] = []
inver_lista l = inver_aux l []

-- funcao que retorna o inverso da lista (otimizado)
inv_list_ot :: [t] -> [t]
inv_list_ot [] = []
inv_list_ot (a:b) = inv_list_ot b ++ [a]

-- funcao que retorna se elemento pertence a lista
pertence :: [Int] -> Int -> Bool
pertence [] _ = False
pertence (a:b) n
    | (a == n) = True
    | otherwise = pertence b n

-- funcao que retorna maior elemento da lista
maior :: [Int] -> Int
maior [a] = a
maior (a:b)
    | (a > maior b) = a
    | otherwise = maior b

-- funcao que verifica se todos os elementos sao pares
todos_pares :: [Int] -> Bool
todos_pares [] = True
todos_pares (a:b)
    | (mod a 2) /= 0 = False
    | otherwise = todos_pares b

-- controe lista com numeros pares de 1 .. n
par :: Int -> Bool
par x = mod x 2 == 0

lista = [x | x <- [1 .. 100], par x]

-- construtor de tupla
tupla = [(x,y) | x <- [1..5], y <- [6..10]]

{- funcao zip: junta duas listas formando uma tupla
zip :: [a] -> [b] -> [(a,b)] -}

-- funcao que inverte lista
inverter :: [a] -> [a]
inverter [] = []
inverter (a:b) = (inverter b)++[a]