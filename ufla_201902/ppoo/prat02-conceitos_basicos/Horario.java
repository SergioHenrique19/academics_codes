public class Horario {
  private int hora;
  private int min;
  private int seg;

  public Horario(int hora, int min, int seg) {
    this.hora = hora;
    this.min = min;
    this.seg = seg;
  }

  public String exibir() {
    return this.hora + "h:" + this.min + "m:" + this.seg + "s";
  }

  public String exibir(int h, int m, int s) {
    return h + "h:" + m + "m:" + s + "s";
  }

  public String formatarTempo(int seg) {
    int h = seg / 3600;
    int m = (seg - (3600 * h)) / 60;
    int s = (seg - (3600 * h) - (m * 60));

    return exibir(h, m, s);
  }
}
