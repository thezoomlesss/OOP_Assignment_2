class Box implements Objects
{
  float x_pos, y_pos; 
  int x, y, held, box_size=80; 
  
  void disp()
  {
    // Drawing the boxes
    strokeWeight(1);
    stroke(255,0,0);
    noFill();
    beginShape();
    vertex(x_pos, y_pos);
    vertex(x_pos + box_size, y_pos);
    vertex(x_pos, y_pos + box_size);
    vertex(x_pos, y_pos);
    vertex(x_pos + box_size, y_pos + box_size);
    vertex(x_pos + box_size, y_pos);
    vertex(x_pos, y_pos + box_size);
    endShape(CLOSE);
  } // end disp

  void move_b()
  {
    if (held==1) // if the box is held then move horizontally
    {
      // If the mech is moving then follow it
      if (mechs.get(mech_index).move_cond==1)
      {
        // Just a small check to fix where the box is displayed while being carried
        if ( mechs.get(mech_index).m_x_pos < background.width_margin+ 10 +(mechs.get(mech_index).new_rand_i*box.box_size) )
        {
          x_pos +=game_speed;
        } else
        {
          x_pos -=game_speed;
        } // end else
      } else  // Mech not moving anymore
      {
        x_pos+=game_speed;
        held=0;
      }// end else
    } // end if
  } // end move_b

  void fall()
  {
    /* 
     Here the boxes will move vertically
     If the box is no longer held
     I am first putting the value 1 in the array of boxes to mark the current position of the box
     checking if it's not on the last line already and if the next line is free so it can keep falling
     check if it's above the floor and lowering the box
     when it reaches the position of the next box (that we calculated before moving) then it will reset the last position
     increment the y so it goes to the right position into the array and puts the value 1 to mark it as occupied
     */
    if (held==0)
    {
      array_rows[y][x]=1;
      if ((y!=background.vert_no_boxes-1) && array_rows[y+1][x]!=1)
      {
        if (y_pos < height-background.height_margin*2 - box_size + 4) 
        {
          y_pos +=game_speed;
          
          /* 
                We check if the pos of the character is inside the area of the box
                If the character is inside it means that we have to display the death screen
          */
          if( character.c_x_pos + character.c_size *0.5 <= x_pos + box_size && character.c_x_pos + character.c_size *0.5 >= x_pos && character.c_y_pos >= y_pos && character.c_y_pos<= y_pos+box_size) state=4;
          
          //  If it is not yet on the last line then it keeps falling
          if ( y_pos > height-background.height_margin*2 - box_size * (background.vert_no_boxes-y-1) + 4) 
          {
            array_rows[y][x]=0;
            y++;
            
          }// end inner if
        } // end middle if
      } // end outer if
    } // end if held == 0
  } // end function fall
}// end box class