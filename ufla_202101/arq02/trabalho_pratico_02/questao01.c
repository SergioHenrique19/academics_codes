#include <immintrin.h>
#include <stdio.h>

int main() {
    __m256 fa = _mm256_setr_ps(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
    __m256 fb = _mm256_setr_ps(2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0);
    __m256 fc = _mm256_setr_ps(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
    
    __m256d da = _mm256_setr_pd(1.0, 1.0, 1.0, 1.0);
    __m256d db = _mm256_setr_pd(2.0, 2.0, 2.0, 2.0);
    __m256d dc = _mm256_setr_pd(1.0, 1.0, 1.0, 1.0);
    
    __m256 ia = _mm256_setr_ps(1, 1, 1, 1, 1, 1, 1, 1);
    __m256 ib = _mm256_setr_ps(2, 2, 2, 2, 2, 2, 2, 2);
    __m256 ic = _mm256_setr_ps(1, 1, 1, 1, 1, 1, 1, 1);

    // __m256i result = (__m256i)_mm256_fmadd_ps((__m256)ia, (__m256)ib, (__m256)ic);
    __m256 result = _mm256_fmadd_ps(ia, ib, ic);
    // __m256d result = _mm256_fmadd_pd(da, db, dc);

    // char opt[6];
    // printf("Select data type: (double, float, int): ");
    // scanf("%s", opt);

    // if(opt[0] == 'd'){

    // }else if(opt[0] == 'f'){

    // }else if(opt[0] == 'i'){

    // }

    /* Display the elements of the result vector */
    float* f = (float*)&result;
    printf("%d ,  %d , %d , %d \n",
    f[0], f[1], f[2], f[3]);

    return 0;
}
