class Box
{
  // x position in the array and held=1 means that it's held by the machine
  float x_pos, y_pos; 
  int x, y, held, box_size=80;
  Box()
  { 
    
  }
  
  void disp()
  {
    // Remmber to work on the colors here
    strokeWeight(1);
    stroke(255,0,0);
    noFill();
    beginShape();
    vertex(this.x_pos, this.y_pos);
    vertex(this.x_pos + box_size, this.y_pos);
    vertex(this.x_pos + box_size, this.y_pos + box_size);
    vertex(this.x_pos, this.y_pos + box_size);
    endShape(CLOSE);
  } 
  
  void move_b()
  {
    if (this.held==1)
    {
      // move horizontally
      if(mechs.get(mech_index).move_cond==1)
      {
        if( mechs.get(mech_index).m_x_pos < background.width_margin+ 10 +(mechs.get(mech_index).new_rand_i*box.box_size) )
        {
          this.x_pos +=game_speed;
        }
        else
        {
          this.x_pos -=game_speed;
          //if( mech.m_x_pos == background.width_margin+ 10 +(mech.new_rand_i*box.box_size) ) this.x_pos++;
          // Why do I have this?
  
        } // end else
      }
      else
      {
        this.x_pos+=game_speed;
        this.held=0;
      }// end else
    }
    else
    {
      /* 
          Here the boxes will move vertically
          I am first putting the value 1 in the array of boxes to mark the current position of the box
          checking if it's not on the last line already and if the next line is free so it can keep falling
          check if it's above the floor and lowering the box
          when it reaches the position of the next box (that we calculated before moving) then it will reset the last position
          increment the y so it goes to the right position into the array and puts the value 1 to mark it as occupied
      */
      array_rows[this.y][this.x]=1;
      if((this.y!=background.vert_no_boxes-1) && array_rows[this.y+1][this.x]!=1)
      {
        if(this.y_pos < height-background.height_margin*2 - box_size + 4) 
        {
          this.y_pos +=game_speed;
          if( this.y_pos > height-background.height_margin*2 - box_size * (background.vert_no_boxes-this.y-1) + 4) 
          {
            array_rows[this.y][this.x]=0;
            this.y++;
            if(this.x == character.c_x-1  && (this.y + 1 == character.c_y || this.y == character.c_y) && ( this.y_pos < height-background.height_margin*2 - box_size -60 )) state=4; //|| 
          }// end inner if
        } // end middle if
      } // end outer if
    } // end else
  } // end move_b
}// end box class