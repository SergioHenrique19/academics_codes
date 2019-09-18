import java.util.Scanner;

public class TesteAgenda{
  public static void main(String[] args) {
    Scanner sc = new Scanner(System.in);
    Agenda agenda = new Agenda();
    String nome = "";
    String end = "";
    String email = "";
    String id = "";
    String estCiv = "";
    int inscEst = 0;
    int op = 0;
    int aux = 0;

    while(op != 5){
      System.out.println("------- M E N U -------");
      System.out.println("(1) Adicionar pessoa fisica");
      System.out.println("(2) Adicionar pessoa juridica");
      System.out.println("(3) Remover contato");
      System.out.println("(4) Visualizar contatos");
      System.out.println("(5) Sair\n");
      System.out.print("Digite a opcao: ");
      op = sc.nextInt();
      sc.nextLine();
      System.out.print("\n\n");

      switch(op){
        case 1:
          System.out.print("Digite o nome: ");
          nome = sc.nextLine();

          System.out.print("Digite o endereco: ");
          end = sc.nextLine();

          System.out.print("Digite o e-mail: ");
          email = sc.nextLine();

          System.out.print("Digite o CPF: ");
          id = sc.nextLine();

          System.out.print("Digite o estado civil: ");
          estCiv = sc.nextLine();

          Pessoa pf = new PessoaFisica(nome, end, email, id, estCiv);
          agenda.adicionarContato(pf);

          System.out.println();
          break;

        case 2:
          System.out.print("Digite o nome: ");
          nome = sc.nextLine();

          System.out.print("Digite o endereco: ");
          end = sc.nextLine();

          System.out.print("Digite o e-mail: ");
          email = sc.nextLine();

          System.out.print("Digite o CNPJ: ");
          id = sc.nextLine();

          System.out.print("Digite a inscricao estadual: ");
          inscEst = sc.nextInt();
          sc.nextLine();

          Pessoa pj = new PessoaJuridica(nome, end, email, id, inscEst);
          agenda.adicionarContato(pj);

          System.out.println();
          break;

        case 3:
          System.out.print("Digite o CPF ou CNPJ: ");
          id = sc.nextLine();

          aux = agenda.buscarPessoa(id);

          if(aux == -1){
            System.out.println("ERRO: Este CNPJ/CPF não existe!");
          }else{
            agenda.removerContato(aux);
          }

          System.out.println();
          break;

        case 4:
          agenda.visualizar();
          
          System.out.println();
          break;

        case 5:
          System.out.println("Saindo...");
          break;

        default:
          System.out.println("ERRO: Opcao indisponivel!");
      }
    }
  }
}
