abstract class Body extends Design
{
  void draw_c(boolean a, float b, float c, float d, color e)
  {
    strokeWeight(1);
    stroke(e);

    if ( a==true)
    {
      fill(e);
    } else
    {
      noFill();
    }

    beginShape();
    vertex(b + d *0.5, c + d * 0.25 - 5);
    vertex(b + d * 0.75, c + d *0.5 - 5);
    vertex(b + d *0.5, c + d * 0.75 - 5);
    vertex(b + d *0.25, c + d *0.5 - 5);
    endShape(CLOSE);
  }
}