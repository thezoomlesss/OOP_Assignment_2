class Char 
{
  float c_x_pos, c_y_pos, left, right, old_pos;
  int c_x, c_y, in_air,  fall_cond=1, up,  c_size=80, new_c_x;
  boolean jump_cond=true, up_released=true, move_box=false;
  
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
    strokeText(String.valueOf(move_box), 300,800);
    
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
      if( this.c_y_pos < this.old_pos - this.c_size - (this.c_size *0.5)) 
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
        // Not the last column  
        if( this.c_x  != background.no_boxes   )  
        { 
          if( character.c_x_pos - character.c_size *0.38 < background.width_margin + (box.box_size * character.c_x) )
          {
            // If there is no box blocking our path
            if( array_rows[this.c_y][this.c_x-1] == 0)
            {
              character.c_x_pos += (character.right - character.left) * 2*game_speed;
            }
            else
            {
              if(move_box==true)
              {
                // We are not on the right limit and  There's no box after the box that we want to move (right)
                if( this.c_x < background.no_boxes    && array_rows[this.c_y][this.c_x] == 0) 
                {
                  // Checking for the box in the boxs arraylist
                  for(int index3=0; index3< mechs.size(); index3++)
                  {
                    for(int index4=0; index4< mech.m_no_box; index4++)
                    {
                      // if the box from the boxs has the position we're looking for
                      if(mechs.get(index3).boxs.get(index4).x == this.c_x - 1 && mechs.get(index3).boxs.get(index4).y == this.c_y)
                      {
                        array_rows[mechs.get(index3).boxs.get(index4).y][mechs.get(index3).boxs.get(index4).x]=0;
                        mechs.get(index3).boxs.get(index4).x++;//= this.c_x;
                        mechs.get(index3).boxs.get(index4).x_pos= background.width_margin + ((mechs.get(index3).boxs.get(index4).x+1) * box.box_size); // was x+1
                        array_rows[mechs.get(index3).boxs.get(index4).y][mechs.get(index3).boxs.get(index4).x]=1;
                        break;
                      } // end inner if
                    } // end for
                  }// end for loop used for mechs arraylist
                } // end mid if
              }// end  if move_box==true 
            } // end else there is no box to the right blocking us
          }
          else
          {
            character.c_x++;
          }
        } // else we are at the last col
        else    
        {
          // if there is no box on the last position then keep going
          if(array_rows[this.c_y][this.c_x-1] == 0) this.c_x_pos += (this.right - this.left) * 2*game_speed;
        }// end if no box on last pos
      } // end mid if
    } // end outer if
    else  
    {
      // going left
      if(this.right - this.left < 0)
      {
        // Not at the left limit
        if(this.c_x_pos> background.width_margin + box.box_size ) 
        {
          // Not on the first  column  
          if( this.c_x != 0   )  
          { 
            if( character.c_x_pos + character.c_size *0.38 > background.width_margin + (box.box_size * character.c_x) )
            {
              // If there is no box blocking our path
              if( array_rows[this.c_y][this.c_x-1] == 0)
              {
                character.c_x_pos += (character.right - character.left) * 2*game_speed;
              }
              else
              {
                if(move_box==true)
                {
                  // We are not on the right limit and  There's no box after the box that we want to move (left)
                  if( this.c_x > 1    && array_rows[this.c_y][this.c_x-2] == 0) 
                  {
                     for(int index3=0; index3< mechs.size(); index3++)
                    {
                      // Checking for the box in the boxs arraylist
                      for(int index4=0; index4< mech.m_no_box; index4++)
                      {
                        // if the box from the boxs has the position we're looking for
                        if(mechs.get(index3).boxs.get(index4).x == this.c_x - 1 && mechs.get(index3).boxs.get(index4).y == this.c_y)
                        {
                          array_rows[mechs.get(index3).boxs.get(index4).y][mechs.get(index3).boxs.get(index4).x]=0;
                          mechs.get(index3).boxs.get(index4).x--;//= this.c_x;
                          mechs.get(index3).boxs.get(index4).x_pos= background.width_margin + ((mechs.get(index3).boxs.get(index4).x+1) * box.box_size); // was x+1
                          array_rows[mechs.get(index3).boxs.get(index4).y][mechs.get(index3).boxs.get(index4).x]=1;
                          break;
                        } // end inner if
                      } // end for used for boxs arraylist
                    }// end for used for mechs arraylist
                  } // end mid if
                }// end  if move_box==true 
              } // end else there is no box to the right blocking us
            }
            else
            {
              character.c_x--;
            }
          } // else we are at the last col
          else    
          {
            // if there is no box on the last position then keep going
            if(array_rows[this.c_y][this.c_x-1] == 0) this.c_x_pos += (this.right - this.left) * 2*game_speed;
          }// end if no box on last pos
        } // end mid if
        
        
      } // end moving left
    } // end elseleft
       
        /*
        // Not at the limit
        if(this.c_x_pos> background.width_margin + this.c_size)
        {
          
          // not on the first col
          if(this.c_x>0)
          {
            
            /*
                Here we update the x index if it crossed to another cell
           
            if( character.c_x_pos + character.c_size *0.38 > background.width_margin + (box.box_size * character.c_x-2) )
            {
              character.c_x_pos += (character.right - character.left) * 2*game_speed;
            }
            else
            {
              character.c_x--;
            }
            
            // There's a box blocking our path to the left
            if(array_rows[this.c_y][this.c_x-2] == 1)
            { 
              
              if(move_box==true)
              {
                if(this.c_x>1)
                {
                  // There's a clear spot after the box to the left
                  if(array_rows[this.c_y][this.c_x-2] == 0)            
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
              } // end if move_box==true
            } 
            else // else there is no box blocking our path
            {
              this.c_x_pos += (this.right - this.left) * 2*game_speed;
            }
          } // end if not on first col
        } // end mid if
      } // end outer if
      */
    
    /*
        Checking for how long should the this keep falling
        If on the floor/bottom then make the fall conditio = 0 so we know when we can jump again
    */
    if(this.c_y == background.vert_no_boxes-1)
    //if(this.c_y_pos + character.c_size>= height-background.height_margin*2+6)
    {
      this.fall_cond=0;
    }  // If in the air and we have a box underneath us
    else if(array_rows[this.c_y+1][this.c_x-1]==1)
    {
      this.fall_cond=0;
    }
    else
    {
      this.fall_cond=1;
    }  
    
    // If it should fall and we are not jumping atm then make it fall
    if(this.fall_cond==1 && this.up != 1)// && (this.c_y_pos + character.c_size< height-background.height_margin*2+6))
    {
      this.c_y_pos += game_speed;
    }
    
    
   // && this.c_y_pos + character.c_size< height-background.height_margin*2+6
    
    
    if( this.c_y_pos + this.c_size > background.width_margin + 26+  (this.c_y+1 * c_size) )
    {
      this.c_y =(int) (this.c_y_pos - background.width_margin +26)/this.c_size;
    }
     //vertical  checking if we are jumping and if the index doesn't match the position on the vertical axis
   // if(this.c_y != (int) (this.c_y_pos - background.width_margin +28  )/this.c_size && this.up !=1)  this.c_y =(int) (this.c_y_pos - background.width_margin+28)/this.c_size;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  } // end function c_move
  
} // end class Char