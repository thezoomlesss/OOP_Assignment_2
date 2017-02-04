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
  
  void c_move()
  {
    if(this.right - this.left > 0)  // going right
    {
      // Not at the limit
      if(this.c_x_pos< background.width_margin + ( (background.no_boxes)* box.box_size ) )
      {
        // Not the last column            this.c_y != background.vert_no_boxes &&
        if( this.c_x  != background.no_boxes  ) // -1  
        { 
          // There's a blocking our path to the right
          if( array_rows[this.c_y][this.c_x] == 1)
          {
            // We are not on the right limit and  There's no box after the box that we want to move (right)
            if( this.c_x < background.no_boxes -1   && array_rows[this.c_y][this.c_x+1] == 0) 
            {
              // Checking for the box in the boxs arraylist
              for(int index4=0; index4< mech.m_no_box; index4++)
              {
                // if the box from the boxs has the position we're looking for
                if(mech.boxs.get(index4).x == this.c_x && mech.boxs.get(index4).y == this.c_y)
                {
                  array_rows[mech.boxs.get(index4).y][mech.boxs.get(index4).x]=0;
                  mech.boxs.get(index4).x= this.c_x+1;
                  mech.boxs.get(index4).x_pos= background.width_margin + ((mech.boxs.get(index4).x+1) * box.box_size);
                  array_rows[mech.boxs.get(index4).y][mech.boxs.get(index4).x]=1;
                  break;
                } // end inner if
              } // end for
            } // end mid if
          } // else there is no box blocking the path
          else 
          {
            this.c_x_pos += (this.right - this.left) * 2*game_speed;
          }
        } // else we are at the last col
        else  // We simply stop checking for other boxes cause we are at the last col and we simply walk 
        {
          this.c_x_pos += (this.right - this.left) * 2*game_speed;
        }// end inner if
      } // end mid if
    } // end outer if
    else  
    {
      // going left
      if(this.right - this.left < 0)
      {
        // Not at the limit
        if(this.c_x_pos> background.width_margin + this.c_size)
        {
          // not on the first col
          if(this.c_x>0)
          {
            // There's a box blocking our path to the left
            if( array_rows[this.c_y][this.c_x-1] == 1)
            { 
              if( this.c_x>1)
              {
                // There's a clear spot after the box to the left
                if(array_rows[this.c_y][this.c_x-2] == 0)            // If we have a box on the first col (x==0) then this crashes the program 
                { // Still crashing even with x==2 for some reason...........................
                  // Finding the box to move in the ArrayList and Array
                  for(int index4=0; index4< mech.m_no_box; index4++)
                  {
                    // if the box from the boxs has the position we're looking for
                    if(mech.boxs.get(index4).x == this.c_x-1 && mech.boxs.get(index4).y == this.c_y)
                    {
                      array_rows[mech.boxs.get(index4).y][mech.boxs.get(index4).x]=0;
                      mech.boxs.get(index4).x= this.c_x-2;
                      mech.boxs.get(index4).x_pos= background.width_margin + ((mech.boxs.get(index4).x+1) * box.box_size);
                      array_rows[mech.boxs.get(index4).y][mech.boxs.get(index4).x]=1;
                      break;
                    } // end inner if
                  } // end for
                }// End if clear spot after box (left)
              }
            } 
            else // else there is no box blocking our path
            {
              this.c_x_pos += (this.right - this.left) * 2*game_speed;
            }
          } // end if not on first col
          else // if on the first col Maybe needed here
          {
            
          }
        } // end mid if
      } // end outer if
    } // end else
    
    /*
        Checking for how long should the character keep falling
    */
    if(character.c_y_pos < height-background.height_margin*2 - character.c_size + 4)
    {
      // Not the last line and not the first column
      if( character.up !=1 && character.c_y != background.vert_no_boxes - 1 && character.c_x != 0)
      { 
        // if there is no box underneath
        if(array_rows[character.c_y+1][character.c_x-1] !=1)
        {
          character.fall_cond=1;
          character.c_y_pos += game_speed;
        }
        else // marking the fact that the character will no longer keep falling
        {
          character.fall_cond=0;
        }
      } // end not last line nor first column
    }
    else // marking the fact that the character will no longer keep falling
    {
      character.fall_cond=0;
    }
    
    // vertical  checking if we are jumping and if the index doesn't match the position on the vertical axis
    if(this.c_y != (int) (this.c_y_pos - background.width_margin +28  )/this.c_size && this.up !=1) this.c_y =(int) (this.c_y_pos - background.width_margin+28)/this.c_size;
    
    
  } // end function c_move
  
} // end class Char