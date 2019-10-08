public abstract class Funcionario implements Comparable<Funcionario>{
  private String nome;
  private String cpf;

  public Funcionario(String nome, String cpf){
    this.nome = nome;
    this.cpf = cpf;
  }

  public String getNome(){
    return nome;
  }

  public String getCpf(){
    return cpf;
  }

  public abstract double calcularSalario();

  @Override
  public int compareTo(Funcionario f){
    if(this.calcularSalario() > f.calcularSalario()){
      return 1;
    }else if(this.calcularSalario() < f.calcularSalario()){
      return -1;
    }else{
      return 0;
    }
  }

  @Override
  public String toString(){
    return "Nome: " + getNome() + "\nCPF: " + getCpf() + "\nSalário: " + calcularSalario() + "\n";
  }
}
