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
raizInteira n = maximum [x | x <- [1 .. n], x*x <= n]
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
novaLista:: [Float] -> [Float]
novaLista a 
    | a == [] = error "Lista vazia"
    | otherwise = [x | x <- a, x < media]
    where media = sum a / (fromIntegral (length a))
-- questao 12 [fim]

-- questao 13 [inicio]
type Nome = String
type Curso = String
type Periodo = Int
type Nota = Float
type Aluno = (Nome, Curso, Periodo, Nota)
type Disciplina = [Aluno]

alunos :: Int -> Aluno
alunos matricula
    | matricula == 1 = ("Rodrigo", "S.Inf.", 3, 6.0)
    | matricula == 2 = ("Joao", "Eng.Comp.", 5, 5.0)
    | matricula == 3 = ("Lucas", "C.Comp.", 8, 3.5)
    | matricula == 4 = ("Ana", "C.Comp.", 5, 8.0)
    | matricula == 5 = ("Maria", "C.Comp.", 7, 9.5)
    | matricula == 6 = ("Paulo", "C.Comp", 6, 6.0)
    | matricula == 7 = ("Jose", "S.Inf.", 8, 7.0)
    | matricula == 8 = ("Eduarda", "C.Comp.", 4, 1.0)
    | matricula == 9 = ("Carla", "Eng.Comp.", 6, 6.5)
    | matricula == 10 = ("Luiz", "C.Comp.", 7, 5.7)
    | matricula == 11 = ("Acabou", "XXX", 4, 8.0)

menorNota :: Aluno -> Float -> Int -> String
menorNota (a,_,_,n) j k
    | a == "Acabou" = nome (alunos 1) j 1
    | otherwise = menorNota (alunos (k + 1)) menor (k + 1)
    where menor | n < j = n
                | otherwise = j

nome :: Aluno -> Float -> Int -> Nome
nome (a,_,_,n) j k
    | n == j = a
    | otherwise = nome (alunos (k + 1)) j (k + 1)

reprovados :: Aluno -> Int -> Int -> Int
reprovados (a,_,_,n) j k
    | a == "Acabou" = j
    | otherwise = reprovados (alunos (k + 1)) itera (k + 1)
    where itera | n < 6.0 = j + 1
                | otherwise = j
-- questao 13 [fim]

-- questao 14 [inicio]
zipar3:: [Int] -> [Int] -> [Int] -> [(Int, Int , Int)]
zipar3 [] _ _ = []
zipar3 _ [] _ = []
zipar3 _ _ [] = []
zipar3 (x:xs) (y:ys) (z:zs) = [ x | x <- (x, y, z) : zipar3 xs ys zs]
-- questao 14 [fim]

-- questao 16 [inicio]
anoBissexto :: Int -> Bool
anoBissexto n
    | mod n 4 == 0 = True
    | otherwise = False
-- questao 16 [fim]

-- questao 17 [inicio]
type Pessoa = (String, Int, Float,Char)

pess :: Int->Pessoa
pess x
    |x==1 = ("Rosa", 27, 1.66,'F')
    |x==2 = ("João", 26, 1.85,'M')
    |x==3 = ("Maria", 67, 1.55,'F')
    |x==4 = ("Jose", 48, 1.78, 'M')
    |x==5 = ("Paulo", 24, 1.93, 'M')
    |x==6 = ("Clara", 38, 1.70,'F')
    |x==7 = ("Bob", 12, 1.45, 'M')
    |x==8 = ("Rosana", 31, 1.58,'F')
    |x==9 = ("Daniel", 75, 1.74, 'M')
    |x==10 = ("Jocileide", 21, 1.69,'F')
    |otherwise = ("Acabou!",0, 0.0, 'x')

maiorelemento xs = foldr (\ (x,y) acc -> if (x == maximum xs) then (x,y) else acc) (0, head xs) (zip xs [1..])

-- encontra a idade dentro de uma tupla de pessoa
q17_a_aux1 (_,idade,_,_) = idade
-- a função maiorelemento retorna uma tupla de (elemento, indice) portanto devemos extrair o indice, que é a resposta da questão
q17_a_aux2 (_, index) = index
-- função principal da questão, busca a tupla do maior elemento da lista depois extrai apenas seu indice
q17_a = q17_a_aux2 (maiorelemento [q17_a_aux1 pessoa| pessoa <- pessoas]) where pessoas = [pess x | x <- [1..10]]

-- lista a idade de todas as pessoas
q17_b_aux1 = [q17_a_aux1 pessoa| pessoa <- pessoas] where pessoas = [pess x | x <- [1..10]]
-- calcula a media desta lista
q17_b =  fromIntegral (sum q17_b_aux1) / fromIntegral (length q17_b_aux1)

-- encontra o sexo dentro de uma tupla de pessoa
q17_c_aux1 (_,_,_,sexo) = sexo
-- aplica um filtro dentro de uma lista de pessoas pra remover os elementos que não são masculinos e maiores de 25 anos, após isso contar os resultados
q17_c = length [pessoa | pessoa <- pessoas, (q17_c_aux1 pessoa == 'M') && (q17_a_aux1 pessoa > 25) ] where pessoas = [pess x | x <- [1..10]]
-- questao 17 [fim]

-- questao 18 [inicio]
somaImpares :: Int -> Int
somaImpares n = sum [x | x <- [1..n], mod x 2 /= 0]
-- questao 18 [fim]
