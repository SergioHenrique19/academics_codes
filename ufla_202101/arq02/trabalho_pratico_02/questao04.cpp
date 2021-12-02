#include <iostream>
#include <iomanip>
#include <immintrin.h>

using namespace std;

int main()
{
      // Declaração do vetor de entrada.
      __m256 entrada = {1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0};

      // Executando uma permutação sobre o vetor de entrada com o dado integer
      // de controle.
      __m256 resultado = _mm256_permute_ps(entrada, 0b11000110);

      // Por fim, exibimos os parâmetros e os resultados da permutação.
      cout << fixed << setprecision(2) << "Vetor de entrada: " << entrada[0] << ", " << entrada[1] << ", " << entrada[2] << ", " << entrada[3] << ", " << entrada[4] << ", " << entrada[5] << ", " << entrada[6] << ", " << entrada[7] << endl;
      cout << "Valor de controle: 0b11000110" << endl;
      cout << fixed << "Vetor resultado: " << setprecision(2) << resultado[0] << ", " << resultado[1] << ", " << resultado[2] << ", " << resultado[3] << ", " << resultado[4] << ", " << resultado[5] << ", " << resultado[6] << ", " << resultado[7] << endl;

      return 0;
}
