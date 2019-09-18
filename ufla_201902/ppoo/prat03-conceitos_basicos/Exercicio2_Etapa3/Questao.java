import java.util.Random;

public class Questao{
  private static int idQuest = 0;
  private String quest;
  private int num1;
  private int num2;
  private int resul;
  
  public Questao(){
    Random gerador = new Random();
    idQuest++;
    num1 = gerador.nextInt(10);
    num2 = gerador.nextInt(10);
    quest = "Questão " + idQuest + " - Quanto é " + num1 + " * " + num2 + "? ";
    resul = num1 * num2;
  }
  
  public String getQuest(){
    return quest;
  }

  public int getIdQuest(){
    return idQuest;
  }
  
  public boolean confere(int resp){
    return resp == resul;
  }
}
