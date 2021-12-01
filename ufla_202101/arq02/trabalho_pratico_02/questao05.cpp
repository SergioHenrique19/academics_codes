#include <immintrin.h>
#include <stdio.h>
#include <iostream>

using namespace std;

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
  __m256d vec1 = _mm256_load_pd(defineOperand(1));
  __m256d vec2 = _mm256_load_pd(defineOperand(2));
  __m256d neg = _mm256_setr_pd(1.0, -1.0, 1.0, -1.0);
  
  /* Step 1: Multiply vec1 and vec2 */
  __m256d vec3 = _mm256_mul_pd(vec1, vec2);

  /* Step 2: Switch the real and imaginary elements of vec2 */
  vec2 = _mm256_permute_pd(vec2, 0x5);
  
  /* Step 3: Negate the imaginary elements of vec2 */
  vec2 = _mm256_mul_pd(vec2, neg);  
  
  /* Step 4: Multiply vec1 and the modified vec2 */
  __m256d vec4 = _mm256_mul_pd(vec1, vec2);

  /* Horizontally subtract the elements in vec3 and vec4 */
  vec1 = _mm256_hsub_pd(vec3, vec4);
  
  /* Display the elements of the result vector */
  double* res = (double*)&vec1;

  printf("\nFinal result: [%lf %lf %lf %lf]\n", res[0], res[1], res[2], res[3]);
  
  return 0;
}