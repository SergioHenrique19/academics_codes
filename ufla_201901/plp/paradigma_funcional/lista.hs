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