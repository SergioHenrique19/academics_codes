public class FuncionarioComissionado extends Funcionario{
  private int totalVendas;
  private double taxaComissao;

  public FuncionarioComissionado(String nome, String cpf, int totalVendas, double taxaComissao){
    super(nome, cpf);
    this.totalVendas = totalVendas;
    this.taxaComissao = taxaComissao;
  }

  public int getTotalVendas(){
    return totalVendas;
  }

  public double getTaxaComissao(){
    return taxaComissao;
  }

  @Override
  public double calcularSalario(){
    return getTotalVendas() * getTaxaComissao();
  }
}
