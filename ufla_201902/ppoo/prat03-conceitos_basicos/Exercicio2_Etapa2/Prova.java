import java.util.Scanner;

public class Prova{
  private Questao questao;
  public int resp;
  
  public Prova(){
    questao = new Questao();
    resp = 0;
  }
  
  // public String aplicar(){
  //   Scanner sc = new Scanner(System.in);
  //   System.out.print(questao.getQuest());
  //   resp = sc.nextInt();
  //   sc.nextLine();
    
  //   if(questao.confere(resp)){
  //     return "Muito bem, você acertou!";
  //   }else{
  //     return "Infelizmente você errou!";
  //   }
  // }

  public String aplicar(){
    Scanner sc = new Scanner(System.in);
    int tent = 1;
    System.out.print(questao.getQuest);
    resp = sc.nextInt();

    while(questao.confere(resp) || )

    if(questao.confere(resp)){}

    sc.close();
  }
}
