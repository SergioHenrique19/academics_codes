public class Bicicleta extends Veiculo{
  private int marchas;

  public Bicicleta(String marca, String modelo, int anoFabricacao, int marchas){
    super(marca, modelo, anoFabricacao);
    this.marchas = marchas;
  }

  public int getMarchas(){
    return marchas;
  }

  @Override
  public String toString(){
    return "Marca: " + getMarca() + "\nModelo: " + getModelo() +
            "\nAno de Fabricação: " + getAnoFabricacao() + "\nMarchas: " + getMarchas();
  }
}
