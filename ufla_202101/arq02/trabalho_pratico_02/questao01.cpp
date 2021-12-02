#include <immintrin.h>
#include <stdio.h>
#include <iostream>

int main()
{
    // Declaração dos vetores do tipo float.
    __m256 fa = _mm256_setr_ps(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
    __m256 fb = _mm256_setr_ps(2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0);
    __m256 fc = _mm256_setr_ps(1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5);

    // Declaração dos vetores do tipo double.
    __m256d da = _mm256_setr_pd(1.0, 1.0, 1.0, 1.0);
    __m256d db = _mm256_setr_pd(2.0, 2.0, 2.0, 2.0);
    __m256d dc = _mm256_setr_pd(1.5, 1.5, 1.5, 1.5);

    // Declaração dos vetores do tipo integer.
    __m256i ia = _mm256_set_epi32(1, 1, 1, 1, 1, 1, 1, 1);
    __m256i ib = _mm256_set_epi32(2, 2, 2, 2, 2, 2, 2, 2);
    __m256i ic = _mm256_set_epi32(1, 1, 1, 1, 1, 1, 1, 1);

    // Para os vetores de float e double fazemos uso da instrução fmadd que
    // realiza ambas as operações matemáticas em um único passo.
    __m256 resultado_float = _mm256_fmadd_ps(fa, fb, fc);
    __m256d resultado_double = _mm256_fmadd_pd(da, db, dc);

    // Em contrapartida, não é oferecido nenhuma instrução que realize soma e
    // multiplicação para vetores do tipo integer. Por isso realizamos o
    // cálculo em dois passos.
    __m256i resultado_multiplicacao = _mm256_mullo_epi32(ia, ib);
    __m256i resultado_soma = _mm256_add_epi32(resultado_multiplicacao, ic);

    // Por fim, exibimos os resultados.
    float *f = (float *)&resultado_float;
    std::cout << "resultado float: " << f[0] << ", " << f[1] << ", " << f[2] << ", " << f[3] << ", " << f[4] << ", " << f[5] << ", " << f[6] << ", " << f[7] << std::endl;

    double *d = (double *)&resultado_double;
    std::cout << "resultado double: " << d[0] << ", " << d[1] << ", " << d[2] << ", " << d[3] << std::endl;

    int *i = (int *)&resultado_soma;
    std::cout << "resultado int: " << i[0] << ", " << i[1] << ", " << i[2] << ", " << i[3] << ", " << i[4] << ", " << i[5] << ", " << i[6] << ", " << i[7] << std::endl;

    return 0;
}
