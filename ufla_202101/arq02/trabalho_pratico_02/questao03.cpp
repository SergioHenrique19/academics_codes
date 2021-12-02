#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <iomanip>

#include <immintrin.h>

using namespace std;

double determinante_2x2(__m256d matriz)
{
    // Calculamos o determinante de uma dada matrix 2x2 realizando o procedimento
    // definido pela subtração da multiplicação das diagonais. Desta forma dado
    // uma matriz A definida por:
    //       ┌      ┐
    //       | a  b |
    //  A := |      |
    //       | c  d |
    //       └      ┘
    // obtemos os seguintes vetores:
    //  linha1 := [a, b, 0, 0]
    //  linha2 := [d, c, 0, 0]
    // que multiplicados nos dão:
    //  matriz_multiplicacao_diagonais := [a * b, d * c, 0, 0]
    // agoram, subtraímos horizontalmente os resultados nos vetores conforme
    // previsto:
    //  subtracao_diagonais := [a * b - d * c, a * b - d * c, 0, 0]
    // por fim, obtemos o primeiro item do vetor que corresponde à equação:
    //  det(A) = a * b - d * c
    __m256d linha_1 = _mm256_setr_pd(matriz[0], matriz[1], 0.0, 0.0);
    __m256d linha_2 = _mm256_setr_pd(matriz[3], matriz[2], 0.0, 0.0);
    __m256d matriz_multiplicacao_diagonais = _mm256_mul_pd(linha_1, linha_2);
    __m256d subtracao_diagonais = _mm256_hsub_pd(matriz_multiplicacao_diagonais, matriz_multiplicacao_diagonais);
    double determinante = _mm256_cvtsd_f64(subtracao_diagonais);
    return determinante;
}

__m256d inversa_2x2(__m256d matriz, double determinante)
{
    // Abaixo, calculamos a matriz inversa de uma dada matrix A de tamanho 2x2 e
    // seu determinante. Desta forma, partimos de:
    //       ┌      ┐
    //       | a  b |
    //  A := |      |
    //       | c  d |
    //       └      ┘
    // e calculamos:
    //                ┌       ┐
    //    T      1    | d  -b |
    //  A :=   -----  |       |
    //         det(A) | -c  a |
    //                └       ┘
    // fazendo uso de uma máscara de sinais definida por:
    //  vetor_troca_sinal := [1.0, -1.0, -1.0, 1.0]
    // e de um vetor composto por 4 cópias do inverso do determinante de A,
    // definido por:
    //                                      -1      -1      -1      -1
    //  vetor_inverso_determinante := [det(A), det(A), det(A), det(A)]
    // obtemos:
    //                     -1          -1            -1           -1
    //  resultado := [det(A)*1*d, det(A)*-1*b , det(A)*-1*c, det(A)*1*a]
    double inverso_determinante = 1 / determinante;
    __m256d vetor_inverso_determinante = _mm256_set1_pd(inverso_determinante);
    __m256d vetor_troca_sinal = _mm256_setr_pd(1.0, -1.0, -1.0, 1.0);

    __m256d diagonal_principal_inversa = _mm256_setr_pd(matriz[3], matriz[1], matriz[2], matriz[0]);
    __m256d resultado = _mm256_mul_pd(_mm256_mul_pd(diagonal_principal_inversa, vetor_troca_sinal), vetor_inverso_determinante);
    return resultado;
}

__m256d multiplicaca_2x2(__m256d matriz_a, __m256d matriz_b)
{
    // Abaixo, calculamos a multiplicação entre matrizes de tamanho 2x2 nomeadas A
    // e B, respectivamente. Desta formas partimos de:
    //       ┌      ┐       ┌      ┐
    //       | a  b |       | e  f |
    //  A := |      |, B := |      |
    //       | c  d |       | g  h |
    //       └      ┘       └      ┘
    // e calculamos:
    //       ┌                  ┐
    //       | ae + bg  af + bh |
    //  R := |                  |
    //       | ce + dg  cf + dh |
    //       └                  ┘
    // criando, primeiamente, dois vetores definidos por:
    //  matriz_b_lado_esquerdo := [e, g, e, g]
    //  matriz_b_lado_direito := [f, h, f, h]
    // para facilitar o processo de multiplicação das linhas e colunas. Novamente,
    // executamos duas multiplicações definidas por:
    //  multiplicacao_lado_esquerdo := [a*e, b*g, c*e, d*g]
    //  multiplicacao_lado_direito := [a*f, b*h, c*f, d*h]
    // que correpondem exetamente às operações necessárias para o calculo da
    // multiplicação entre matrizes. Finalmente, com uma soma horizontal temos:
    //  resultado := [ae + bg, af + bh, ce + dg, cf + dh]
    __m256d matriz_b_lado_esquerdo = _mm256_setr_pd(matriz_b[0], matriz_b[2], matriz_b[0], matriz_b[2]);
    __m256d matriz_b_lado_direito = _mm256_setr_pd(matriz_b[1], matriz_b[3], matriz_b[1], matriz_b[3]);

    __m256d multiplicacao_lado_esquerdo = _mm256_mul_pd(matriz_a, matriz_b_lado_esquerdo);
    __m256d multiplicacao_lado_direito = _mm256_mul_pd(matriz_a, matriz_b_lado_direito);

    __m256d resultado = _mm256_hadd_pd(multiplicacao_lado_esquerdo, multiplicacao_lado_direito);
    return resultado;
}

__m256d subtrai_2x2(__m256d matriz_a, __m256d matriz_b)
{
    __m256d resultado = _mm256_sub_pd(matriz_a, matriz_b);
    return resultado;
}

int main(int argc, char const *argv[])
{
    double matriz[4][4];

    // Lê a matriz M de tamanho 4x4 do arquivo csv em anexo.
    int numero_linha = 0;
    ifstream arquivo_matriz("matriz.csv");
    for (string conteudo_linha; getline(arquivo_matriz, conteudo_linha); numero_linha++)
    {
        int numero_elemento = 0;
        istringstream stream_linha(conteudo_linha);
        for (string elemento; getline(stream_linha, elemento, ';'); numero_elemento++)
        {
            matriz[numero_linha][numero_elemento] = stod(elemento);
        }
    }

    // Devido ao tamanho de M iremos aplicar o complemento de Schur visando obter
    // seu determinante. Desta forma, começamos por dividir a matriz M em 4 blocos
    // de tamanho 2x2 nomeados A, B, C e D, respectivamente:
    //       ┌      ┐
    //       | A  B |
    //  M := |      |
    //       | C  D |
    //       └      ┘
    // tendo em vista que A é invertível, denotamos o complemento deste modo:
    //                  -1
    //  M/A := D - C . A   . B
    // por fim, para obter o determinante de M, aplicamos a seguinte propriedade:
    //  det(M) = det(A) . det(M/A)

    __m256d A = _mm256_setr_pd(matriz[0][0], matriz[0][1], matriz[1][0], matriz[1][1]);
    __m256d B = _mm256_setr_pd(matriz[0][2], matriz[0][3], matriz[1][2], matriz[1][3]);
    __m256d C = _mm256_setr_pd(matriz[2][0], matriz[2][1], matriz[3][0], matriz[3][1]);
    __m256d D = _mm256_setr_pd(matriz[2][2], matriz[2][3], matriz[3][2], matriz[3][3]);

    double determinante_A = determinante_2x2(A);
    __m256d A_inversa = inversa_2x2(A, determinante_A);
    __m256d A_inversa_vezes_B = multiplicaca_2x2(A_inversa, B);
    __m256d C_vezes_A_inversa_vezes_B = multiplicaca_2x2(C, A_inversa_vezes_B);
    __m256d D_menos_C_vezes_A_inversa_vezes_B = subtrai_2x2(D, C_vezes_A_inversa_vezes_B);
    double resultado = determinante_A * determinante_2x2(D_menos_C_vezes_A_inversa_vezes_B);

    cout << "Determinante: " << fixed << setprecision(2) << resultado << endl;

    return 0;
}
