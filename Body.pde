abstract class Body extends Design
{
  float r=0;     // The angle of rotation
  boolean angle_left=false, angle_right=false;
  
  void draw_c(boolean push, float x_pos, float y_pos, float d, color colour)
  {
    strokeWeight(1);
    stroke(colour);
    
    // If we are in push mode then we fill the shape
    if ( push==true)
    {
      fill(colour);
    } else
    {
      noFill();
    }
    
    if(angle_left==true) r-=0.06;
    if(angle_right==true) r+=0.06;
    
    // Here we do the rotation of the character
    pushMatrix();
    translate(x_pos  + d *0.5, y_pos + d * 0.5 - 10);
    rotate(r);
    
    // Drawing the character
    beginShape();
    vertex( 0, - d * 0.25);
    vertex( d * 0.25, 0);
    vertex( 0, d * 0.25 );
    vertex( - d *0.25, 0);
    endShape(CLOSE);
    
    popMatrix();
  } // end void draw_c
} // end class Body