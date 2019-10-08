public class TesteEmpresa{
  public static void main(String[] args) {
    Empresa empresa = new Empresa("EmpresaX","123456789/1000");
    Funcionario func1 = new FuncionarioHorista("Luiz","123456789-10",100.0,160.0);
    Funcionario func2 = new FuncionarioComissionado("Zé","987654321-00",300,50.0);
    empresa.admitirFuncionario(func1);
    empresa.admitirFuncionario(func2);
    empresa.gerarRelatorioDePrioridade();
  }
}
