abstract class Body extends Design
{
  float r=0;
  boolean angle_left=false, angle_right=false;
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
    
    if(angle_left==true) r-=0.06;
    if(angle_right==true) r+=0.06;
    
    // Here we also do the rotation of the character
    pushMatrix();
    translate(b  + d *0.5, c + d * 0.5 - 10);
    rotate(r);
    
    beginShape();
    vertex( 0, - d * 0.25);
    vertex( d * 0.25, 0);
    vertex( 0, d * 0.25 );
    vertex( - d *0.25, 0);
    endShape(CLOSE);
    
    popMatrix();
  }
}