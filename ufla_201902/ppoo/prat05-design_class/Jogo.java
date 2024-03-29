/**
 *  Essa eh a classe principal da aplicacao "World of Zull".
 *  "World of Zuul" eh um jogo de aventura muito simples, baseado em texto.
 *  Usuarios podem caminhar em um cenario. E eh tudo! Ele realmente
 *  precisa ser estendido para fazer algo interessante!
 *
 *  Para jogar esse jogo, crie uma instancia dessa classe e chame o metodo
 *  "jogar".
 *
 *  Essa classe principal cria e inicializa todas as outras: ela cria os
 *  ambientes, cria o analisador e comeca o jogo. Ela tambeme avalia e
 *  executa os comandos que o analisador retorna.
 *
 * @author  Michael Kölling and David J. Barnes (traduzido por Julio Cesar Alves)
 * @version 2011.07.31 (2016.02.01)
 */

public class Jogo{
    private Analisador analisador;
    private Ambiente ambienteAtual;

    /**
     * Cria o jogo e incializa seu mapa interno.
     */
    public Jogo(){
        criarAmbientes();
        analisador = new Analisador();
    }

    /**
     * Cria todos os ambientes e liga as saidas deles
     */
    private void criarAmbientes(){
        Ambiente fora, anfiteatro, cantina, laboratorio, escritorio, sotao;

        // cria os ambientes
        fora = new Ambiente("do lado de fora da entrada principal de uma universidade");
        anfiteatro = new Ambiente("no anfiteatro");
        cantina = new Ambiente("na cantina do campus");
        laboratorio = new Ambiente("no laboratorio de computacao");
        escritorio = new Ambiente("na sala de administracao dos computadores");
        sotao = new Ambiente("no sotao acima do anfiteatro");

        // inicializa as saidas dos ambientes -- n, l, s, o
        fora.ajustarSaidas("leste", anfiteatro);
        fora.ajustarSaidas("sul", laboratorio);
        fora.ajustarSaidas("oeste", cantina);
        anfiteatro.ajustarSaidas("oeste", fora);
        anfiteatro.ajustarSaidas("cima", sotao);
        cantina.ajustarSaidas("leste", fora);
        laboratorio.ajustarSaidas("norte", fora);
        laboratorio.ajustarSaidas("leste", escritorio);
        escritorio.ajustarSaidas("oeste", laboratorio);
        sotao.ajustarSaidas("baixo", anfiteatro);

        ambienteAtual = fora;  // o jogo comeca do lado de fora
    }

    /**
     *  Rotina principal do jogo. Fica em loop ate terminar o jogo.
     */
    public void jogar()
    {
        imprimirBoasVindas();

        // Entra no loop de comando principal. Aqui nos repetidamente lemos
        // comandos e os executamos ate o jogo terminar.

        boolean terminado = false;
        while (! terminado) {
            Comando comando = analisador.pegarComando();
            terminado = processarComando(comando);
        }
        System.out.println("Obrigado por jogar. Ate mais!");
    }

    /**
     * Imprime a mensagem de abertura para o jogador.
     */
    private void imprimirBoasVindas(){
        System.out.println();
        System.out.println("Bem-vindo ao World of Zuul!");
        System.out.println("World of Zuul eh um novo jogo de aventura, incrivelmente chato.");
        System.out.println("Digite 'ajuda' se voce precisar de ajuda.");
        System.out.println();
        imprimirLocalizacaoAtual();
    }

    /**
     * Solução da etapa 1
     * Método que imprime/apresenta as saídas disponíveis do lugar em que se encontra o jogador
     */
    private void imprimirLocalizacaoAtual(){
        System.out.println("Voce esta " + ambienteAtual.getDescricao());
        System.out.print("Saidas: ");
        System.out.print(ambienteAtual.getSaidas());
        System.out.println();
    }

    /**
     * Dado um comando, processa-o (ou seja, executa-o)
     * @param comando O Comando a ser processado.
     * @return true se o comando finaliza o jogo.
     */
    private boolean processarComando(Comando comando){
        boolean querSair = false;

        if(comando.ehDesconhecido()) {
            System.out.println("Eu nao entendi o que voce disse...");
            return false;
        }

        String palavraDeComando = comando.getPalavraDeComando();
        if (palavraDeComando.equals("ajuda")){
            imprimirAjuda();
        }
        else if (palavraDeComando.equals("ir")){
            irParaAmbiente(comando);
        }
        else if (palavraDeComando.equals("sair")){
            querSair = sair(comando);
        }else if(palavraDeComando.equals("observar")){
          observar();
        }

        return querSair;
    }

    // Implementacoes dos comandos do usuario

    /**
     * Printe informacoes de ajuda.
     * Aqui nos imprimimos algo bobo e enigmatico e a lista de
     * palavras de comando
     */
    private void imprimirAjuda(){
        System.out.println("Voce esta perdido. Voce esta sozinho. Voce caminha");
        System.out.println("pela universidade.");
        System.out.println();
        System.out.println("Suas palavras de comando sao:");
        System.out.println("   ir sair ajuda observar");
    }

    private void observar(){
      imprimirLocalizacaoAtual();
    }

    /**
     * Tenta ir em uma direcao. Se existe uma saida entra no
     * novo ambiente, caso contrario imprime mensagem de erro.
     */
    private void irParaAmbiente(Comando comando){
        if(!comando.temSegundaPalavra()){
            // se nao ha segunda palavra, nao sabemos pra onde ir...
            System.out.println("Ir pra onde?");
            return;
        }

        String direcao = comando.getSegundaPalavra();

        // Tenta sair do ambiente atual
        Ambiente proximoAmbiente = null;
        proximoAmbiente = ambienteAtual.getAmbiente(direcao);

        if(proximoAmbiente == null){
            System.out.println("Nao ha passagem!");
        }else{
            ambienteAtual = proximoAmbiente;
            imprimirLocalizacaoAtual();
        }
    }

    /**
     * "Sair" foi digitado. Verifica o resto do comando pra ver
     * se nos queremos realmente sair do jogo.
     * @return true, se este comando sai do jogo, false, caso contrario
     */
    private boolean sair(Comando comando){
        if(comando.temSegundaPalavra()){
            System.out.println("Sair o que?");
            return false;
        }
        else{
            return true;  // sinaliza que nos queremos sair
        }
    }
}
