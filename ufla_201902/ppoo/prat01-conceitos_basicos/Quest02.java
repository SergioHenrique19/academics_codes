import java.util.Scanner;

public class Quest02{
  public static void main(String[] args){
    // Inicio do sc
    Scanner sc = new Scanner(System.in);
    
    // Dados
    float x;
    int num;
    float[] meses;   // meses = new int[t];
    float result = 0;
    
    // Entradas
    x = sc.nextFloat();
    num = sc.nextInt();
    meses = new float[num];
    
    for(int i = 0; i < num; i++){
      meses[i] = sc.nextFloat();
      result += meses[i] + (meses[i] * (x/100)) + (result * (x/100));
    }
    
    System.out.println(result);
    
    // Fim do sc
    sc.close();
  }
}

