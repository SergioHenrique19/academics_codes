import java.util.Scanner;

public class Quest01{
  public static void main(String[] args){
    // Inicio do sc
    Scanner sc = new Scanner(System.in);
    
    // Dados exijidos
    int sexo;   // 0 -> F, 1 -> M
    int idade;
    double anosTrab;
    double result;
    
    // Variaveis de controle
    double ped;   // Pedagio de 30%
    
    // Entrada
    sexo = sc.nextInt();
    idade = sc.nextInt();
    anosTrab = sc.nextDouble();
    
    if(sexo == 0){
      if(anosTrab < 15.0){
        result = 62;
      }else{
        ped = (30.0 - anosTrab) + ((30.0 - anosTrab) * 0.3);
        result = idade + ped;
      }
    }else{
      if(anosTrab < 20.0){
        result = 65;
      }else{
        ped = (35.0 - anosTrab) + ((35.0 - anosTrab) * 0.3);
        result = idade + ped;
      }
    }
    
    System.out.println(result);
    
    // Fim do sc
    sc.close();
  }
}

