import java.util.*;

public class Empresa{
  private String nome;
  private String cnpj;
  private ArrayList<Funcionario> funcionarios;

  public Empresa(String nome, String cnpj){
    this.nome = nome;
    this.cnpj = cnpj;
    funcionarios = new ArrayList<Funcionario>();
  }

  public void admitirFuncionario(Funcionario f){
    funcionarios.add(f);
    Collections.sort(funcionarios);
  }

  public void gerarRelatorioDePrioridade(){
    for(Funcionario f: funcionarios){
      System.out.println(f);
    }
  }
}
