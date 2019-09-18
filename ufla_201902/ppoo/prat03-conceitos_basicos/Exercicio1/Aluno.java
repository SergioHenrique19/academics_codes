public class Aluno {
  private String nome;
  private String categoria;   //bolsista ou não-bolsista
  private int[] notas;
  private int cont;
  
  // Construtor
  public Aluno(String nome, String categoria, int tamanho){
    this.nome = nome;
    this.categoria = categoria;
    notas = new int[tamanho];
    cont = 0;
  }
  
  // Retorna o nome do aluno
  public String getNome(){
    return nome;
  }
  
  // Retorna a nota numa dada disciplina do vetor (indice)
  public int nota(int ind){
    return notas[(ind - 1)];
  }
  
  // Calcula o coeficiente de rendimento
  public double coeficienteRend(){
    double soma = 0;
    double media = 0;
    
    for(int i = 0; i < notas.length; i++){
      soma += notas[i];
    }
    
    media = soma / notas.length;
    
    return media;
  }
  
  // Inserir notas no vetor
  public void inserirNotas(int val){
    notas[cont] = val;
    cont++;
  }
  
  // Retorna a situacao do aluno (regular ou desligado)
  public String situacao(){
    if(categoria.equals("bolsista")){
      if(coeficienteRend() >= 75.0){
        return "Regular";
      }else{
        return "Desligado";
      }
    }else{
      if(coeficienteRend() >= 70.0){
        return "Regular";
      }else{
        return "Desligado";
      }
    }
  }
}
