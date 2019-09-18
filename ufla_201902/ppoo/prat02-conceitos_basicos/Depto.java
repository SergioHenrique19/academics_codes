public class Depto {
  private String nome;
  private String[] docente;
  private int numeroCursos;
  private int numeroAlunos;
  private int contador;

  public Depto(String nome, int qtdadeDocentes) {
    this.nome = nome;
    docente = new String[qtdadeDocentes];
    contador = 0;
  }

  public Depto(String nome, int numeroCursos, int numeroAlunos, int qtdeDocentes) {
    this.nome = nome;
    docente = new String[qtdeDocentes];
    this.numeroCursos = numeroCursos;
    this.numeroAlunos = numeroAlunos;
    contador = 0;
  }

  public void cadastrarDocente(String nomeDocente) {
    docente[contador] = nomeDocente;
    contador++;
  }

  public void setNumeroCursos(int numeroCursos) {
    this.numeroCursos = numeroCursos;
  }

  public void setNumeroAlunos(int numeroAlunos) {
    this.numeroAlunos = numeroAlunos;
  }

  public void mostrarDetalhes() {
    System.out.println("Nome do departamento: " + this.nome);
    System.out.println("Professores: ");

    for(String s: docente){
      System.out.printf("%s%s %n", "        ", s);
    }

    System.out.println("Numero de Cursos: " + this.numeroCursos);
    System.out.println("Numero de Alunos: " + this.numeroAlunos);
  }
}
