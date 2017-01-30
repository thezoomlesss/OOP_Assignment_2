class Char 
{
  float c_x_pos, c_y_pos, left, right, old_pos;
  int c_x, c_y, in_air,  fall_cond=1, up,  c_size=80, new_c_x;
  boolean jump_cond=true, up_released=true;
  
  void spawn_c(int x, int y)
  {
    this.c_x=x;
    this.c_y=y;
    this.c_x_pos=background.width_margin + (this.c_x * c_size);
    this.c_y_pos=background.width_margin +  (this.c_y * c_size);
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
  
  // Jumping until we get to the height of the original pos - the amount we want to jump by
  void jump()
  {
    if( this.up != 0 )
    {
      this.c_y_pos -= game_speed;
      if( this.c_y_pos < this.old_pos - this.c_size -5) 
      {
        this.jump_cond=true;
        this.up=0;
      }
    } // end if not jumping
  } // end jump function
  
} // end class Char