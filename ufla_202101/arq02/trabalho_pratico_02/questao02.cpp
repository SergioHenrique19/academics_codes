#include <iostream>
#include <immintrin.h>

using namespace std;

int main()
{
  double escalar;

  cout << "Digite o escalar (double): ";
  cin >> escalar;

  // Alocação do vetor X alinhado
  double *x = (double *)aligned_alloc(32, 64 * sizeof(double));
  x[0] = 1.0;
  x[1] = 1.0;
  x[2] = 1.0;
  x[3] = 1.0;

  // Carrega o vetor X da memória
  __m256d xVetDaMemoria = _mm256_load_pd(x);

  // Realiza a multiplicação do vetor X com escalar
  __m256d xVetEstacalar = _mm256_set1_pd(escalar);

  // Realiza a multiplicação do vetor X com o vetor anterior
  __m256d xVetMult = _mm256_mul_pd(xVetDaMemoria, xVetEstacalar);

  // Alocação do vetor Y alinhado
  double *y = (double *)aligned_alloc(32, 64 * sizeof(double));
  y[0] = 1.0;
  y[1] = 1.0;
  y[2] = 1.0;
  y[3] = 1.0;

  // Carrega o vetor Y da memória
  __m256d yVetDaMemoria = _mm256_load_pd(y);

  // Realiza a adição entre os vetores da multiplicação de X e o Y carregado da memória
  __m256d vetResult = _mm256_add_pd(xVetMult, yVetDaMemoria);

  // Aloca um vetor alinhado vazio na memória
  double *vetResultAlocado = (double *)aligned_alloc(32, 64 * sizeof(double));

  // Armazena o vetor resultado na memória
  _mm256_store_pd(vetResultAlocado, vetResult);

  // Carrega o vetor resultado da memória
  __m256d vetResultCarregado = _mm256_load_pd(vetResultAlocado);

  // Imprime valores
  cout << vetResultCarregado[0] << ", " << vetResultCarregado[1] << ", " << vetResultCarregado[2] << ", " << vetResultCarregado[3] << endl;

  return 0;
}
