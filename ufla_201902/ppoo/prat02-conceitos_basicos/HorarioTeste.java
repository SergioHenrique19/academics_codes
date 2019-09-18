public class HorarioTeste {
  public static void main(String[] args) {
    Horario horario = new Horario(10, 15, 43);

    System.out.println(horario.exibir());
    System.out.println(horario.formatarTempo(3690));
    System.out.println(horario.formatarTempo(3521));
    System.out.println(horario.formatarTempo(59));
  }
}
