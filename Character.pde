class Char 
{
  float c_x_pos, c_y_pos, left, right;
  int c_x, c_y, in_air, c_size=80;
  
  
  void spawn_c(int x, int y)
  {
    this.c_x_pos=background.width_margin + (x * c_size);
    this.c_y_pos=background.width_margin +  (y * c_size);
    this.in_air=1;
  }
  
  void draw_c()
  {
    strokeWeight(1);
    stroke(0,255,0);
    noFill();
    beginShape();
    vertex(this.c_x_pos, this.c_y_pos);
    vertex(this.c_x_pos + this.c_size, this.c_y_pos);
    vertex(this.c_x_pos + this.c_size, this.c_y_pos + this.c_size);
    vertex(this.c_x_pos, this.c_y_pos + this.c_size);
    endShape(CLOSE);
  }
  
  void move_c()
  {
    
  }
  
} // end class Char