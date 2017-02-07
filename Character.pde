class Char 
{
  float c_x_pos, c_y_pos, left, right, old_pos;
  int c_x, c_y, in_air,  fall_cond=1, up,  c_size=80, new_c_x;
  boolean jump_cond=true, up_released=true, move_box=false;
  color c_colour;
  
  void spawn_c(int x, int y)
  {
    this.c_colour= color(random(0,255),random(0,255),random(0,255));
    this.c_x=x;
    this.c_y=y;
    this.c_x_pos=background.width_margin + (c_x * c_size);
    this.c_y_pos=background.width_margin +  (c_y * c_size);
    this.in_air=1;
  }
  
  void draw_c()
  {
    strokeText(String.valueOf(move_box), 300,800);
    
    strokeWeight(1);
    stroke(c_colour);
    
    if( move_box==true)
    {
      fill(c_colour);
    }
    else
    {
      noFill();
    }
    
    beginShape();
    vertex(c_x_pos + c_size *0.5, c_y_pos + c_size * 0.25);
    vertex(c_x_pos + c_size * 0.75, c_y_pos + c_size *0.5);
    vertex(c_x_pos + c_size *0.5, c_y_pos + c_size * 0.75);
    vertex(c_x_pos + c_size *0.25, c_y_pos + c_size *0.5);
    endShape(CLOSE);
    
    
  }
  
  // Jumping until we get to the height of the original pos - the amount we want to jump by
  void jump()
  {
    if( up != 0 )
    {
      c_y_pos -= game_speed;
      if( c_y_pos < old_pos - c_size - (c_size *0.5)) 
      {
        jump_cond=true;
        up=0;
      }
      
    } // end if not jumping
  } // end jump function
  
  void c_move()
  {
    if(right - left > 0)  // going right
    {
      // Not at the limit
      if(c_x_pos< background.width_margin + ( (background.no_boxes)* box.box_size ) )
      {
        // Not the last column  
        if( c_x  != background.no_boxes   )  
        { 
          if( character.c_x_pos - character.c_size *0.38 < background.width_margin + (box.box_size * character.c_x) )
          {
            // If there is no box blocking our path
            if( array_rows[c_y][c_x-1] == 0)
            {
              character.c_x_pos += (character.right - character.left) * 2*game_speed;
            }
            else
            {
              if(move_box==true)
              {
                // We are not on the right limit and  There's no box after the box that we want to move (right)
                if( c_x < background.no_boxes    && array_rows[c_y][c_x] == 0) 
                {
                  // Checking for the box in the boxs arraylist
                  for(int index3=0; index3< mechs.size(); index3++)
                  {
                    for(int index4=0; index4< mechs.get(index3).m_no_box; index4++)
                    {
                      // if the box from the boxs has the position we're looking for
                      if(mechs.get(index3).boxs.get(index4).x == c_x - 1 && mechs.get(index3).boxs.get(index4).y == c_y)
                      {
                        array_rows[mechs.get(index3).boxs.get(index4).y][mechs.get(index3).boxs.get(index4).x]=0;
                        mechs.get(index3).boxs.get(index4).x++;//= c_x;
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
          if(array_rows[c_y][c_x-1] == 0) c_x_pos += (right - left) * 2*game_speed;
        }// end if no box on last pos
      } // end mid if
    } // end outer if
    else  
    {
      // going left
      if(right - left < 0)
      {
        // Not at the left limit
        if(c_x_pos> background.width_margin + box.box_size ) 
        {
          // Not on the first  column  
          if( c_x != 0   )  
          { 
            if( character.c_x_pos + character.c_size *0.38 > background.width_margin + (box.box_size * character.c_x) )
            {
              // If there is no box blocking our path
              if( array_rows[c_y][c_x-1] == 0)
              {
                character.c_x_pos += (character.right - character.left) * 2*game_speed;
              }
              else
              {
                if(move_box==true)
                {
                  // We are not on the right limit and  There's no box after the box that we want to move (left)
                  if( c_x > 1    && array_rows[c_y][c_x-2] == 0) 
                  {
                     for(int index3=0; index3< mechs.size(); index3++)
                    {
                      // Checking for the box in the boxs arraylist
                      for(int index4=0; index4< mechs.get(index3).m_no_box; index4++)
                      {
                        // if the box from the boxs has the position we're looking for
                        if(mechs.get(index3).boxs.get(index4).x == c_x - 1 && mechs.get(index3).boxs.get(index4).y == c_y)
                        {
                          array_rows[mechs.get(index3).boxs.get(index4).y][mechs.get(index3).boxs.get(index4).x]=0;
                          mechs.get(index3).boxs.get(index4).x--;//= c_x;
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
            if(array_rows[c_y][c_x-1] == 0) c_x_pos += (right - left) * 2*game_speed;
          }// end if no box on last pos
        } // end mid if
        
        
      } // end moving left
    } // end else left
       
    
    
    
    
    /*
        Checking for how long should the this keep falling
        If on the floor/bottom then make the fall conditio = 0 so we know when we can jump again
    */
    if(c_y == background.vert_no_boxes-1)
    //if(c_y_pos + character.c_size>= height-background.height_margin*2+6)
    {
      fall_cond=0;
    }  // If in the air and we have a box underneath us
    else if(array_rows[c_y+1][c_x-1]==1)
    {
      fall_cond=0;
    }
    else
    {
      fall_cond=1;
    }  
    
    // If it should fall and we are not jumping atm then make it fall
    if(fall_cond==1 && up != 1)// && (c_y_pos + character.c_size< height-background.height_margin*2+6))
    {
      c_y_pos += game_speed;
    }
    
    
   // && c_y_pos + character.c_size< height-background.height_margin*2+6
    
    
    if( c_y_pos + c_size > background.width_margin + 26+  (c_y+1 * c_size) )
    {
      c_y =(int) (c_y_pos - background.width_margin +26)/c_size;
    }
     //vertical  checking if we are jumping and if the index doesn't match the position on the vertical axis
   // if(c_y != (int) (c_y_pos - background.width_margin +28  )/c_size && up !=1)  c_y =(int) (c_y_pos - background.width_margin+28)/c_size;
  
  } // end function c_move
  
} // end class Char