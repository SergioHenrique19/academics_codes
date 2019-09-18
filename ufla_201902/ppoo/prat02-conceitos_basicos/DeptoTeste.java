import java.util.Scanner;

public class DeptoTeste {
  public static void main(String[] args) {
    Scanner sc = new Scanner(System.in);
    String nome = "";
    String docs = "";
    int numCurs = 0;
    int numAlus = 0;
    int tam = 0;

    System.out.print("Digite o nome do dpto: ");
    nome = sc.nextLine();

    System.out.print("Digite a qtde de docentes: ");
    tam = sc.nextInt();
    sc.nextLine();

    if(tam == 0){
      Depto dpto = new Depto(nome, 3);

      for(int i = 0; i < 3; i++){
        docs = sc.nextLine();
        dpto.cadastrarDocente(docs);
      }

      System.out.print("Digite qtde de cursos: ");
      numCurs = sc.nextInt();
      dpto.setNumeroCursos(numCurs);

      System.out.print("Digite qtde de alunos: ");
      numAlus = sc.nextInt();
      dpto.setNumeroAlunos(numAlus);

      dpto.mostrarDetalhes();
    }else{
      System.out.print("Digite qtde de cursos: ");
      numCurs = sc.nextInt();

      System.out.print("Digite qtde de alunos: ");
      numAlus = sc.nextInt();
      sc.nextLine();

      Depto depto = new Depto(nome, numCurs, numAlus, tam);

      for(int i = 0; i < tam; i++){
        docs = sc.nextLine();
        depto.cadastrarDocente(docs);
      }

      depto.mostrarDetalhes();
    }

    sc.close();
  }
}