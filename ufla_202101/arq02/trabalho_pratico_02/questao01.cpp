#include <immintrin.h>
#include <stdio.h>
#include <iostream>

int main() {
    __m256 fa = _mm256_setr_ps(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
    __m256 fb = _mm256_setr_ps(2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0);
    __m256 fc = _mm256_setr_ps(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
    
    __m256d da = _mm256_setr_pd(1.0, 1.0, 1.0, 1.0);
    __m256d db = _mm256_setr_pd(2.0, 2.0, 2.0, 2.0);
    __m256d dc = _mm256_setr_pd(1.0, 1.0, 1.0, 1.0);
    
    __m256i ia = _mm256_setr_epi32(1, 1, 1, 1, 1, 1, 1, 1);
    __m256i ib = _mm256_setr_epi32(2, 2, 2, 2, 2, 2, 2, 2);
    __m256i ic = _mm256_setr_epi32(1, 1, 1, 1, 1, 1, 1, 1);

    __m256i resultMult = _mm256_mul_epi32(ia, ib);
    __m256i resultInt = _mm256_add_epi32(resultMult, ic);

    __m256 resultFloat = _mm256_fmadd_ps(fa, fb, fc);
    __m256d resultDouble = _mm256_fmadd_pd(da, db, dc);


    float* f = (float*)&resultFloat;
    printf("resultado float: %lf, %lf, %lf, %lf, %lf, %lf, %lf, %lf \n",
    f[0], f[1], f[2], f[3], f[4], f[5], f[6], f[7]);

    double* d = (double*)&resultDouble;
    printf("resultado double: %lf, %lf, %lf, %lf \n",
    d[0], d[1], d[2], d[3]);

    int* i = (int*)&resultInt;

    std::cout << "resultado int: " << i[0] << ", " << i[1] << ", " << i[2] << ", " << i[3] 
              << ", " << i[4] << ", " << i[5] << ", " << i[6] << ", " << i[7] << std::endl;

    return 0;
}
