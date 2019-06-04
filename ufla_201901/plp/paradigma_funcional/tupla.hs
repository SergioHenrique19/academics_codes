-- funcao que soma elementos da tupla
func :: (Int, Int) -> (Int, Int) -> (Int, Int)
func (a, b) (c, d) = (a + c, b + d)

nomes :: (String, String, String)
nomes = ("Sergio", "DeMolay", "Programmer")

-- funcoes que acessam n-elementos da tupla
selec_prim (x, _, _) = x
selec_sec (_, y, _) = y
selec_ter (_, _, z) = z

-- funcao que define novo tipo de dado
type Nome = String
type Idad = Int
type Ling = String
type Pessoa = (Nome, Idad, Ling)

alguem :: Pessoa
alguem = ("sergio", 20, "java")