#include <immintrin.h>
#include <stdio.h>
#include <iostream>

using namespace std;

/* 
  Método resposável por inicializar um vetor operando, através do recebimento
  dos respectivos valores via terminal.
*/
double* defineOperand(unsigned int id){
    double* aux = (double*)aligned_alloc(32, 64 * sizeof(double));

    for (unsigned int i = 0; i < 4; i++){
        printf("\nInsert a value for vector %i at position [%i]: ", id, i);
        cin >> aux[i];
    }

    printf("\n");

    return aux;

}

int main() {
  /* Inicialização dos operandos 1 e 2 para a multiplicação vetorial */
  __m256d vector1 = _mm256_load_pd(defineOperand(1));
  __m256d vector2 = _mm256_load_pd(defineOperand(2));

  /* Inicialização de um vetor de negação */
  __m256d denial = _mm256_setr_pd(1.0, -1.0, 1.0, -1.0);
  

  /*
      A multiplicação de números complexos trabalha com a adoção do mesmo método adotado na expansão 
    de um produto notável, através da multiplicação cada termo do primeiro fator por todos os membros 
    do segundo fator. Tal processo pode ser descrito da seguinte forma: 
    
      - Sejam z1 e z2 dois números complexos, tais que: z1 = a + bi e z2 = c + di.

      - Definiremos a multiplicação de z1 e z2 da seguinte forma:

      - z1⋅z2 = (a + bi) ⋅ (c + di) = ac -bd + (ad _ bc)i

    Para o exercício proposto, a solução formulada consiste na contabilização de dois vetores:

      * Vetor 1 = [ a, b, x, y ]
      * Vetor 2 = [ c, d, z, w ]
        
    Cada par de elementos dos respectivos vetores será utilizado para realizar o cálculo de cada
    produto complexo:

      * (a + bi)(c + di) = ac - bd + (ad + bc)i
      * (x + zi)(y + wi) = xz - yw + (xw + yz)i
      
    Consequentemente, o produto final consistirá no seguinte formato:

      * Produto final = [ (ac - bd), (ad + bc), (xz - yw), (xw + yz) ]

    Portanto, a realização de tal cálculo consistirá em 5 passos principais (conforme demonstrado
    no exemplo proposto pelo enunciado), demonstrados a seguir:
  */

  /* Neste passo, é realizada uma multiplicação vetorial comum entre os operandos 1 e 2*/
  __m256d product = _mm256_mul_pd(vector1, vector2);


  /* 
    Após o cálculo do produto, o operando 2 realiza uma troca de posições entre cada par de elementos,
    contendo um número real e imaginário para cada coleção.
  */
  vector2 = _mm256_permute_pd(vector2, 0x5);
  

  /* 
    Após a troca de posições de cada par de elementos do operando 2, o mesmo tem seus alguns de seus
    respectivos valores "negados", através de uma multiplicação entre o Vector2 e Denial
  */
  vector2 = _mm256_mul_pd(vector2, denial);  
  

  /*
    Após a negação de alguns elementos do operando 2, um novo produto é calculado entre Vector1 e Vector2. 
  */
  __m256d modified_product = _mm256_mul_pd(vector1, vector2);


  /* 
    Por fim, é realizada uma subtração horizontal para obter a configuração desejada, utilizando os operandos
    Product e Modified_Product. Por consequência, o segundo elemento de cada par corresponde ao valor multiplicado 
    pela unidade imaginária "i".
  */
  vector1 = _mm256_hsub_pd(product, modified_product); // Equivalente a => [ (ac - bd), (ad + bc), (xz - yw), (xw + yz) ]
  
  /* Por fim, é realizada a impressão final do resultado calculado */
  double* result = (double*)&vector1;
  printf("\nFinal result: [%lf %lf %lf %lf]\n", result[0], result[1], result[2], result[3]);
  
  return 0;
}