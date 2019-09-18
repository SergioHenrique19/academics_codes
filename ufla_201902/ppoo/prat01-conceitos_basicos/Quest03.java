import java.util.Scanner;

public class Quest03{
  public static void main(String[] args){
    // Inicio do sc
    Scanner sc = new Scanner(System.in);
    
    // Dados
    int kmReg;
    String piloto1;
    float[] tempos1;
    String piloto2;
    float[] tempos2;
    String result;
    
    // Entradas
    kmReg = sc.nextInt();
    sc.nextLine();
    piloto1 = sc.nextLine();
    tempos1 = new float[kmReg];
    
    for(int i = 0; i < kmReg; i++){
      tempos1[i] = sc.nextFloat();
    }
    
    sc.nextLine();
    piloto2 = sc.nextLine();
    tempos2 = new float[kmReg];
    
    for(int i = 0; i < kmReg; i++){
      tempos2[i] = sc.nextFloat();
    }
    
    // Piloto na liderança a cada km
    for(int i = 0; i < kmReg; i++){
      result = tempos1[i] < tempos2[i] ? piloto1 : piloto2;
      System.out.print(result + " ");
    }
    
    System.out.println();
    
    // Piloto com melhor tempo no último km
    for(int i = 0; i < kmReg; i++){
      if(i == 0){
        result = tempos1[i] < tempos2[i] ? piloto1 : piloto2;
      }else{
        result = (tempos1[i] - tempos1[(i - 1)]) < (tempos2[i] - tempos2[(i - 1)]) ? piloto1 : piloto2;
      }
      
      System.out.print(result + " ");
    }
    
    System.out.println();
    
    // Fim do sc
    sc.close();
  }
}
