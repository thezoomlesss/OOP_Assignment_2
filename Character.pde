class Char 
{
  float c_x_pos, c_y_pos;
  int c_x, c_y, in_air=1;
  
  
  void spawn_c(float x, float y)
  {
    this.c_x_pos=x;
    this.c_y_pos=y;
  }
  
  void draw_c()
  {
    strokeWeight(1);
    stroke(0,255,0);
    noFill();
    beginShape();
    vertex(this.c_x_pos, this.c_y_pos);
    vertex(this.c_x_pos + box.box_size, this.c_y_pos);
    vertex(this.c_x_pos + box.box_size, this.c_y_pos + box.box_size);
    vertex(this.c_x_pos, this.c_y_pos + box.box_size);
    endShape(CLOSE);
  }
  
  void move_c()
  {
    
  }
  void keyPressed()
  {
    
  }
}