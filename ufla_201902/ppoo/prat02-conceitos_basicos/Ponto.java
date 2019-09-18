import java.lang.Math;

public class Ponto {
  private double x;
  private double y;

  public Ponto(double x, double y) {
    this.x = x;
    this.y = y;
  }

  public String getPonto() {
    return "As coordenadas (x,y) do ponto são: (" + this.x + "; " + this.y +")";
  }

  public double calcularDistancia(double a, double b) {
    return Math.sqrt(Math.pow((a - this.x), 2) + Math.pow((b - this.y), 2));
  }
}
