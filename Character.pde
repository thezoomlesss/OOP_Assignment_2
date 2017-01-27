class Char 
{
  float c_x_pos, c_y_pos, left, right;
  int c_x, c_y, in_air, fall_cond=1, c_size=80;
  int[][] c_array_boxes;
  
  void spawn_c(int x, int y)
  {
    c_array_boxes= new int[background.no_boxes+1][background.vert_no_boxes];
    
    // initializing the floor with 1 in the array
    for(int index=0; index<background.vert_no_boxes; index++)
    {
      c_array_boxes[background.no_boxes][index]=1;
    }
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