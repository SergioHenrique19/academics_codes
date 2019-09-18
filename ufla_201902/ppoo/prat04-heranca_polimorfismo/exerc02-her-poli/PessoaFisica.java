public class PessoaFisica extends Pessoa{
  private String estadoCivil;

  public PessoaFisica(String nome, String endereco, String email, String cpf, String estadoCivil){
    super(nome, endereco, email, cpf);
    this.estadoCivil = estadoCivil;
  }

  public String getEstadoCivil(){
    return estadoCivil;
  }

  @Override
  public String toString(){
    return "Nome: " + getNome() + "\nEndereco: " + getEndereco() + "\nEmail: " + getEmail() +
            "\nCPF: " + getId() + "\nEstado civil: " + getEstadoCivil();
  }
}
