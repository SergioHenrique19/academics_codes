import java.util.Scanner;

public class CarrinhoTeste {
  public static void main(String[] args) {
    Scanner sc = new Scanner(System.in);
    String nome = " ";
    int d = 0;
    int m = 0;
    int a = 0;
    int tam = 0;
    String prod = " ";

    System.out.print("Digite o seu nome: ");
    nome = sc.nextLine();

    System.out.print("Digite o dia: ");
    d = sc.nextInt();

    System.out.print("Digite o mes: ");
    m = sc.nextInt();

    System.out.print("Digite o ano: ");
    a = sc.nextInt();

    System.out.print("Digite o tamanho do carrinho: ");
    tam = sc.nextInt();
    sc.nextLine();

    if(tam == 0){
      Carrinho car = new Carrinho(nome, d, m, a);
  
      for(int i = 0; i < 5; i++){
        prod = sc.nextLine();
        car.insertItem(prod);
      }

      car.exibir();
    } else {
      Carrinho carr = new Carrinho(nome, d, m, a, tam);

      for(int i = 0; i < tam; i++){
        prod = sc.nextLine();
        carr.insertItem(prod);
      }

      carr.exibir();
    }

    sc.close();
  }
}