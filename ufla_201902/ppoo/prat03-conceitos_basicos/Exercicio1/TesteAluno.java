import java.util.Scanner;

public class TesteAluno {
  public static void main(String[] args){
    Scanner sc = new Scanner(System.in);
    String nome = "";
    String cat = "";
    int tam = 0;
    int nota = 0;
    
    System.out.print("Digite o nome do aluno: ");
    nome = sc.nextLine();
    
    System.out.print("Insira a categoria do aluno (bolsista/não bolsista): ");
    cat = sc.nextLine();
    
    System.out.print("Entre com a quantidade de disciplinas cursadas: ");
    tam = sc.nextInt();
    
    Aluno aluno = new Aluno(nome, cat, tam);
    
    for(int i = 0; i < tam; i++){
        System.out.printf("Insira a nota na disciplina %d: ", (i+1));
        nota = sc.nextInt();
        aluno.inserirNotas(nota);
    }
    
    sc.nextLine();
    
    System.out.println("############# RELATÓRIO FINAL #############");
    System.out.printf("Coeficiente de Rendimento: %.2f%n", aluno.coeficienteRend());
    System.out.printf("Situação final: %s%n", aluno.situacao());
    
    sc.close();
  }
}
