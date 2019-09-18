public class Pessoa{
  private String nome;
  private String endereco;
  private String email;
  private String id;

  public Pessoa(String nome, String endereco, String email, String id){
    this.nome = nome;
    this.endereco = endereco;
    this.email = email;
    this.id = id;
  }

  public String getNome(){
    return nome;
  }

  public String getEndereco(){
    return endereco;
  }

  public String getEmail(){
    return email;
  }

  public String getId(){
    return id;
  }

  @Override
  public String toString(){
    return "Nome: " + getNome() + "\nEndereco: " + getEndereco() +
            "\nEmail: " + getEmail() + "\nId: " + getId();
  }
}
