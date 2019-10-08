import java.util.*;

public class Frota{
  private ArrayList<Veiculo> veiculos;

  public Frota(){
    veiculos = new ArrayList<Veiculo>();
  }

  public void inserirVeiculo(Veiculo v){
    veiculos.add(v);
  }

  public void gerarRelatorio(){
    for(Veiculo v: veiculos){
      System.out.println(v);
      System.out.println("-----------------");
    }
  }
}
