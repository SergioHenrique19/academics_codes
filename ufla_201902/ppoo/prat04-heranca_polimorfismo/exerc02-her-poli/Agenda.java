import java.util.ArrayList;

public class Agenda{
  private ArrayList<Pessoa> contatos;

  public Agenda(){
    contatos = new ArrayList<Pessoa>();
  }

  public void adicionarContato(Pessoa p){
    contatos.add(p);
  }

  public void removerContato(int ind){
    contatos.remove(ind);
  }

  public int buscarPessoa(String id){
    int ind = -1;

    for(Pessoa p: contatos){
      if(p.getId().equals(id)){
        ind = contatos.indexOf(p);
      }
    }

    return ind;
  }

  public void visualizar(){
    for(Pessoa p: contatos){
      System.out.println(p);
      System.out.println();
    }
  }
}
