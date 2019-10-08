public class Carro extends Veiculo implements Tributavel{
  private String categoria;

  public Carro(String marca, String modelo, int anoFabricacao, String categoria){
    super(marca, modelo, anoFabricacao);
    this.categoria = categoria;
  }

  public String getCategoria(){
    return categoria;
  }

  @Override
  public String toString(){
    return "Marca: " + getMarca() + "\nModelo: " + getModelo() +
            "\nAno de Fabricação: " + getAnoFabricacao() + "\nCategoria: " + getCategoria() + "\nIPVA: " + calcularIPVA();
  }

  @Override
  public double calcularIPVA(){
    if(getCategoria().equals("passeio")){
      return 1500/(2019 - getAnoFabricacao());
    }else{
      return 1000/(2019 - getAnoFabricacao());
    }
  }
}
