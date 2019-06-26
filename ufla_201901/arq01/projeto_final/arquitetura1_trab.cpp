/* TRABALHO FINAL GCC117 - ARQUITETURA DE COMPUTADORES 1
    PROFESSOR: Andre Vital Saude
    GRUPO: Fábio Junio Rolin de Oliveira
           Kaio Vinícius de Morais Silva
           Otávio de Lima Soares
           Sérgio Henrique Menta Garcia

    FONTE: https://github.com/SergioHenrique19/academics_codes/tree/master/ufla_201901/arq01/projeto_final
*/

#include <iostream>
#include <fstream>
#include <cstdlib>
using namespace std;

//Declaracao das variáveis globais
unsigned int Mem[32768];
unsigned int PC = 0x0040;
unsigned int IR;
unsigned int LR;
unsigned int SP = 32767;
unsigned int reg[30];
unsigned int A,B; 
unsigned int *D;
unsigned int result;

//Declaracao das variaveis de controle
bool pop = false;
bool branch = false;
bool Z = 0;
bool N = 0; 
int execode;
bool wb = false;
bool acabou = false;

//Declaracao e abertura do arquivo de saida
ofstream out("saida.txt");

//Funcao de Busca da Instrucao
void BuscaInstrucao(){}

//Funcao de Decodificacao da Instrucao
void Decodificacao(){}

//Funcao de Execucao
void ExeMem() {}

//Funcao de Write Back
void EscritaRegistrador() {}

//Programa Principal
int main() {
    return 0;
}
