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
void BuscaInstrucao(){
    IR = Mem[PC>>1];
    //Escrita no arquivo da leitura de instrucao
    out << "ri 0x" << std::hex << PC << endl;
}

//Funcao de Decodificacao da Instrucao
void Decodificacao(){
    //Switch para a deteccao dos 3 primeiros bits da instrucao
    switch(IR & 0x7F800000){
        case(0x0000):
            switch(IR & 0x1800){
                case(0x0000)://INSTRUCAO LSL
                    A = ((IR & 0x07C0) >> 6);
                    B = reg[(IR & 0x0038) >> 3];
                    D = &reg[(IR & 0x0007)];
                    wb = true;
                    execode = 5;
                    break;
                case(0x0800)://INSTRUCAO LSR
                    A = ((IR & 0x07C0) >> 6);
                    B = reg[(IR & 0x0038) >> 3];
                    D = &reg[(IR & 0x0007)];
                    wb = true;
                    execode = 6;
                    break;
            }
            switch(IR & 0x1E00){
                case(0x1800)://INSTRUCAO ADD PARA DOIS REGISTRADORES
                    B = reg[(IR & 0x01C0) >> 6]; 
                    A = reg[(IR & 0x0038) >> 3]; 
                    D = &reg[(IR & 0x0007)];
                    execode = 0;
                    wb = true;
                    break;
                case(0x1A00)://INSTRUCAO SUB PARA DOIS REGISTRADORES
                    B = reg[(IR & 0x01C0) >> 6]; 
                    A = reg[(IR & 0x0038) >> 3]; 
                    D = &reg[(IR & 0x0007)];
                    execode = 1;
                    wb = true;
                    break;
                case(0x1C00)://INSTRUCAO ADD PARA UM OFFSET DE 3 BITS
                    B = reg[(IR & 0x01C0) >> 6]; 
                    A = ((IR & 0x0038) >> 3); 
                    D = &reg[(IR & 0x0007)];
                    execode = 0;
                    wb = true;
                    break;
                case(0x1E00)://INSTRUCAO SUB PARA UM OFFSET DE 3 BITS
                    B = reg[(IR & 0x01C0) >> 6]; 
                    A = ((IR & 0x0038) >> 3); 
                    D = &reg[(IR & 0x0007)];
                    execode = 1;
                    wb = true;
                    break;
            }
            break;
        case(0x2000):
            switch(IR & 0x3800){
                case(0x2000)://INSTRUCAO MOV
                    A = (IR & 0x00FF);
                    execode = 2;
                    wb = true;
                    break;
                case(0x2800)://INSTRUCAO CMP
                    B = (IR & 0x00FF);
                    A = reg[(IR & 0x0700)>>8];
                    execode = 1;
                    wb = false;
                    break;
                case(0x3000)://INSTRUCAO ADD PARA UM OFFSET DE 8 BITS
                    D = &reg[(IR & 0x0700)>>8];
                    B = reg[(IR & 0x0700)>>8];
                    A = (IR & 0x00FF);
                    execode = 0;
                    wb = true;
                    break;
                case(0x3800)://INSTRUCAO SUB PARA UM OFFSET DE 8 BITS
                    D = &reg[(IR & 0x0700)>>8];
                    B = reg[(IR & 0x0700)>>8];
                    A = (IR & 0x00FF);
                    execode = 1;
                    wb = true;
                    break;
            }
        case(0x4000):
            switch(IR & 0x5E00){
                case(0x5600)://INSTRUCAO LDRH PARA DOIS REGISTRADORES
                    A = reg[(IR & 0x0038) >> 3];
                    B = reg[(IR & 0x01C0) >> 6];
                    D = &reg[(IR & 0x0007)];
                    execode = 4;
                    wb = true;
                    break;
            }
            switch(IR & 0x4C00){
                case(0x4800)://INSTRUCAO LDR RELACIONADA AO PC
                    D = &reg[(IR & 0x0700)>>8];
                    A = ((IR & 0x00FF) << 2);
                    B = PC;
                    execode = 4;
                    wb = true;
                    break;
                case(0x4600)://INSTRUCAO MOV HD RS
                    A = reg[(IR & 0x0038) >> 3];
                    D = &reg[(IR & 0x0007)];
                    execode = 2;
                    wb = true;
                    break;
            }
            break;
        case(0x6000):
            switch(IR & 0x7800){
                case(0x6000)://INSTRUCAO STR COM OFFSET DE 5 BITS
                    A = ((IR & 0x07C0)<<2);
                    B = reg[(IR & 0x0038)>>3];
                    D = &reg[(IR & 0x0007)];
                    wb = false;
                    execode = 3;
                    break;
                case(0x6800)://INSTRUCAO LDR COM OFFSET DE 5 BITS
                    A = ((IR & 0x07C0)<<2);
                    B = reg[(IR & 0x0038)>>3];
                    D = &reg[(IR & 0x0007)];
                    wb = true;
                    execode = 4;
                    break;
            }
            break;
        case(0x8000):
            switch(IR & 0x8800){
                case(0x8000)://INSTRUCAO STRH COM OFFSET DE 5 BITS
                    B = ((IR & 0x07C0) >> 6) << 1;
                    A = reg[(IR & 0x0038) >> 3];
                    D = &reg[(IR & 0x0007)];
                    wb = false;
                    execode = 3;
                    break;
                case(0x8800)://INSTRUCAO LDRH COM OFFSET DE 5 BITS
                    B = ((IR & 0x07C0) >> 6) << 1;
                    A = reg[(IR & 0x0038) >> 3];
                    D = &reg[(IR & 0x0007)];
                    wb = true;
                    execode = 4;
                    break;
            }
            break;
        case(0xA000):
            switch(IR & 0xBF00){
                case(0xBD00)://CASO PARA O TERMINO DO PROGRAMA
                    acabou = true;  //caso a instrução seja POP de PC, parar a execução do programa
                    break;
                case(0xB000):
                    switch(IR & 0xB080){
                        case(0xB000)://INSTRUCAO ADD RELACIONADA AO SP
                            A = SP;
                            B = (IR & 0x007F);
                            D = &SP;
                            execode = 0;
                            wb = true;
                            break;
                        case(0xB080)://INSTRUCAO SUB RELACIONADA AO SP
                            A = SP;
                            B = (IR & 0x007F);
                            D = &SP;
                            execode = 1;
                            wb = true;
                            break;
                    }
                case(0xA800)://INSTRUCAO ADD USANDO O SP E OUTRO REG
                    A = ((IR & 0x00FF) << 2);
                    B = SP;
                    D = &reg[(IR & 0x0700) >> 8];
                    wb = true;
                    execode = 0;
                    break;
                default://CASO PARA IGNORAR AS PRÓXIMAS PARTES DA EXECUCAO
                    //Este caso e verdadeiro para qualquer instrucao
                    //push ou pop que nao seja a do termino do programa
                    pop = true;
                    break;
            }
            break;
        case(0xC000):
            switch(IR & 0xDF80){//INSTRUCAO BLE
                //Decidimos dividir a decodificacao entre offset positivo
                //e offset negativo, gerando dois casos
                case(0xDD00):  //BLE para offset positivo
                    A = ((IR & 0x00FF) << 1);
                    execode = 8;
                    wb = false;
                    break;
                case(0xDD80):  //BLE para offset negativo
                    {
                        signed short l = ((IR & 0x00FF) << 1);
                        signed short aneg = 0xFE00 | l;
                        A = -aneg;
                        execode = 9;
                        wb = false;
                        break;
                    }
            }
            break;
        case(0xE000)://INSTRUCAO B(branch)
            //Decidimos dividir a decodificacao ente offset positivo
            //e offset negativo
            {
                //BRANCH COM OFFEST NEGATIVO
                signed short aux = ((IR & 0x07FF) << 1);
                if(aux < 0){
                    signed short aneg = 0xF000 | aux;
                    A = -aneg;
                    execode = 10;
                } else{
                    //BRANCH COM OFFEST POSITIVO
                    A = aux;
                    execode = 7;
                }
                wb = false;
                branch = true;
            }
            break;
        default://Caso o programa leia uma instrucao não implementada,
                //a execucao é encerrada
            acabou = true;
            break;
        
    }
}

//Funcao de Execucao
void ExeMem() {
    switch (execode) {
        case 0://ADD
            result = A + B;
            N = (int(A)+int(B)) < 0;
            Z = (int(A)+int(B)) == 0;
            break;
        case 1://SUB,CMP
            result = A - B;
            N = ((int(A)-int(B)) < 0);
            Z = (int(A)-int(B) == 0);
            break;
        case 2://MOV
            result = A;
            N = int(A) < 0;
            Z = int(A) == 0;
            break;
        case 3://STR, STRH
            result = A+B;
            Mem[result>>1] = *D;
            out << "wd 0x" << std::hex << result << endl;
            break;
        case 4://LDR, LDRH
            result = Mem[((A+B)>>1)];
            out << "rd 0x" << std::hex << (A+B) << endl;
            break;
        case 5://LSL
            result = B << A;
            N = ((int(B) << int(A)) < 0);
            Z = ((int(B) <<int(A)) == 0);
            break;
        case 6://LSR
            result = B >> A;
            N = ((int(B) >> int(A)) < 0);
            Z = ((int(B) >> int(A)) == 0);
            break;
        case 7://B COM OFFSET POSITIVO
            PC = PC + A + 4;
            break;
        case 8://BLE COM OFFSET POSITIVO
            if(Z or N){
                branch = true;
                PC = PC + A + 4;
            }
            break;
        case 9://BLE COM OFFSET NEGATIVO
            if(Z or N){
                branch = true;
                PC = PC - A + 4;
            }
            break;
        case 10://B COM OFFSET NEGATIVO
            PC = PC - A + 4;
            break;
    }
}

//Funcao de Write Back
void EscritaRegistrador() {
    if(wb){
        *D = result;
        wb = false;
    }
}

//Programa Principal
int main() {
    //Limpando o terminal para a execucao do programa
    system("clear");
    system("clear");
    cout << "Escreva o nome do arquivo desejado" << endl;
    string nomeArq;
    ifstream arq;
    //Leitura do nome do arquivo para a execucao
    do {
        cin >> nomeArq;
        arq.open(nomeArq.c_str());
    } while(!arq.is_open());
    unsigned short reader;
    //Leitura do arquivo e carregamento para a memória
    int cont = 0;
    while(!arq.eof()){
        arq.read(reinterpret_cast<char*> (&reader), sizeof(unsigned short));
        Mem[cont++] = reader;
    }
    //Execucao dos estagios da maquina
    while(!acabou){
        BuscaInstrucao();
        Decodificacao();
        //Verificacao do fim do programa e instrucao push/pop
        if((!acabou) and (!pop)){
            ExeMem();
            EscritaRegistrador();
        }
        //Atualizacao do controle de push pop
        pop = false;
        //Verificacao da existencia de Branch
        if(!branch){
            PC += 2;
        }
        //Atualizacao do controle de branch
        branch = false;
    }
    return 0;
}
