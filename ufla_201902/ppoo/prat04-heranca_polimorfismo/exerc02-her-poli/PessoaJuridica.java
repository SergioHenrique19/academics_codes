public class PessoaJuridica extends Pessoa{
  private int inscricaoEstadual;

  public PessoaJuridica(String nome, String endereco, String email, String cnpj, int inscricaoEstadual){
    super(nome, endereco, email, cnpj);
    this.inscricaoEstadual = inscricaoEstadual;
  }

  public int getInscricaoEstadual(){
    return inscricaoEstadual;
  }

  @Override
  public String toString(){
    return "Nome: " + getNome() + "\nEndereco: " + getEndereco() + "\nEmail: " + getEmail() +
            "\nCNPJ: " + getId() + "\nInscricao estadual: " + getInscricaoEstadual();
  }
}
