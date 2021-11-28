#include <iostream>
#include <fstream>
#include <sstream>
#include <string>

using namespace std;

int main(int argc, char const *argv[])
{
  float matriz[4][4];

  ifstream arquivo_matriz("matriz.csv");
  for (string conteudo_linha; getline(arquivo_matriz, conteudo_linha);)
  {
    int numero_linha = 0;
    istringstream stream_linha(conteudo_linha);
    for (string elemento; getline(stream_linha, elemento, ';');)
    {
      cout << elemento << endl;
    }
  }
  return 0;
}
