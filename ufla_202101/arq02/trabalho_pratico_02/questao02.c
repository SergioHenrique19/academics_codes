#include <immintrin.h>
#include <stdio.h>

int main() {
    double* x = (double*)aligned_alloc(32, 64 * sizeof(double));
    x[0] = 1.0;
    x[1] = 1.0;
    x[2] = 1.0;
    x[3] = 1.0;

    printf("Type a double scalar: ");
    double scalar;
    scanf("%lf", &scalar);

    for(int i=0; i<4; i++){
        x[i] *= scalar;
    }

    __m256d XfromMemory = _mm256_load_pd(x);
    
    double* y = (double*)aligned_alloc(32, 64 * sizeof(double));
    y[0] = 1.0;
    y[1] = 1.0;
    y[2] = 1.0;
    y[3] = 1.0;

    __m256d YfromMemory = _mm256_load_pd(y);
    
    __m256d result = _mm256_add_pd(XfromMemory, YfromMemory);

    double* resultAddr = (double*)aligned_alloc(32, 64 * sizeof(double));

    _mm256_store_pd(resultAddr, result);

    __m256d checkResult = _mm256_load_pd(resultAddr);

    /* Display the elements of the result vector */
    double* f = (double*)&checkResult;
    printf("%lf ,  %lf , %lf , %lf \n",
    f[0], f[1], f[2], f[3]);

    return 0;
}
