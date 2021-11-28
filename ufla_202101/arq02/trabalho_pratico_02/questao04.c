#include <immintrin.h>
#include <stdio.h>

int main() {

    __m256 A = {1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0};

    __m256 result = _mm256_permute_ps(A, 0b11000110);

    float* entrada = (float*)&A;
    printf("Vetor de entrada: ");
    printf("%lf ,  %lf , %lf , %lf, %lf ,  %lf , %lf , %lf \n",
          entrada[0],entrada[1],entrada[2],entrada[3],entrada[4],entrada[5],entrada[6],entrada[7]);

    printf("Valor de controle: 0b11000110\n");

    float* saida = (float*)&result;
    printf("Vetor resultado: ");
    printf("%lf ,  %lf , %lf , %lf, %lf ,  %lf , %lf , %lf \n",
          saida[0],saida[1],saida[2],saida[3],saida[4],saida[5],saida[6],saida[7]);

    return 0;
}
