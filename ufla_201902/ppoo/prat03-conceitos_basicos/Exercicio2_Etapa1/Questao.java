import java.util.Random;

public class Questao{
  private String quest;
  private int num1;
  private int num2;
  private int resul;
  
  public Questao(){
    Random gerador = new Random();
    num1 = gerador.nextInt(10);
    num2 = gerador.nextInt(10);
    quest = "Quanto é " + num1 + " * " + num2 + "?";
    resul = num1 * num2;
  }
  
  public String getQuest(){
    return quest;
  }
  
  public boolean confere(int resp){
    return resp == resul;
  }
}
