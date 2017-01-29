/* 
  Mohamad Zabad C15745405
  OPP Assignment 2
  
  To do list:
  - A way of logging in (+text file to save it)
  - Menu with New game, color options and leaderboards
  - Add base platform
  - Add character
  - Add blocks
  - Add interaction with the blocks
  - Add random box drops
  - Add movement
  - Jump physics
  - Add detection algo to see how many blocks are there on the lowest ground
  - Leaderboards
  
*/

void setup()
{
  fullScreen();
  frameRate(120);
  background(0,0,17);
  // Doing this here because the setup runs before the Map class and we need those values initialised before we create the array
  background.grid_initial();
  array_rows=new int[background.vert_no_boxes][background.no_boxes];
  character.spawn_c((int)random(background.no_boxes *0.25, background.no_boxes *0.75), (int)random(background.vert_no_boxes *0.85, background.vert_no_boxes *0.90));
  mech.spawn_m();
  mech.spawn_box();
}

// Global declaration area
int[][] array_rows;
int game_speed=2;
//int deleted;

// Creating the objects that will be added into the ArrayLists
Map background=new Map();
Box box= new Box();
Mech mech= new Mech();
Char character= new Char();

// ArrayLists
ArrayList <Box> boxes= new ArrayList <Box>();
ArrayList <Mech> mechs= new ArrayList <Mech>();

void draw()
{
  //println(frameRate);
  background.grid();
  mech.draw_m();
  character.draw_c();
  for(int index2=0; index2 < mech.boxs.size(); index2++)
  {
    /*
    if((deleted==1) && (mech.boxs.get(index2).y== background.vert_no_boxes-1))
    {
      stroke(0,255,0);
      println("Green");
    }
    else
    {
      stroke(255,0,0);
    }
    */
    
    mech.boxs.get(index2).disp();
  }
  update();
  
  // This updates the position of the character
 
  
  
  /*
         Don't mind this
         It's just a test
         
       
  println(background.vert_no_boxes, background.no_boxes);
  
   
  for(int index2=0; index2<background.vert_no_boxes; index2++)
  {
    for(int index1=0; index1<background.no_boxes; index1++)
    { 
      print(array_rows[index2][index1]+" ");
    }
    println();
  }
  
    println();println();println();
   */ 
}
 

void update()
{
  
  /*
      Here we are checking if the last line of the array is full 
      If it's full then we have to clear it
      To do that we initialize a condition to be true
      Check every array box from the last line and if it's empty then negate the condition
      If the condition is still true after going through the whole line
      We remove from the ArrayList the boxes that are present on the last line of the array
      After that we also clear the last line of the array
  */
  
  int clear_line_cond=1; 
  //deleted=0;
  
  // Checking if the last line of the array is full
  for(int index3=0; index3<background.no_boxes; index3++)
  {
    if(array_rows[background.vert_no_boxes-1][index3]==0)
    {
      clear_line_cond=0;
    }
  }
  
  if(clear_line_cond==1)
  {
    // removing from ArrayList
    for(int index3= mech.boxs.size()-1; index3>-1; index3--)
    {
      if(mech.boxs.get(index3).y== background.vert_no_boxes-1)
      {
        mech.boxs.remove(index3);
        mech.m_no_box--;
      }
    }
    
    //Removing from array  No real reason why I'm going backwards
    for(int index3=background.no_boxes-1; index3>-1; index3--)
    {
      array_rows[background.vert_no_boxes-1][index3]=0;
      //deleted=1;
    }  
  }// end if
  
  mech.move_m();
  
  // Moving all the boxes that are in the arraylist boxs
  for(int index2=0; index2 < mech.boxs.size(); index2++)
  {
    mech.boxs.get(index2).move_b();
  }
  
  /*
      Update for character's position
      We check the places next to the character to see if they're free
      for left we have an -1 because the index we use is already greater than the actual position by one
  */
                  
  if(character.right - character.left > 0)  // going right
  {
    // Not at the limit
    if(character.c_x_pos< background.width_margin + ( (background.no_boxes)* box.box_size ) )
    {
      // Not the last column            character.c_y != background.vert_no_boxes &&
      if( character.c_x != background.no_boxes - 1)
      { 
        // There's a blocking our path to the right
        if( array_rows[character.c_y][character.c_x] == 1)
        {
          // We are not on the right limit and  There's no box after the box that we want to move (right)
          if( character.c_x < background.no_boxes - 1 && array_rows[character.c_y][character.c_x+1] == 0)
          {
            // Checking for the box in the boxs arraylist
            for(int index4=0; index4< mech.m_no_box; index4++)
            {
              // if the box from the boxs has the position we're looking for
              if(mech.boxs.get(index4).x == character.c_x && mech.boxs.get(index4).y == character.c_y)
              {
                array_rows[mech.boxs.get(index4).y][mech.boxs.get(index4).x]=0;
                mech.boxs.get(index4).x= character.c_x+1;
                mech.boxs.get(index4).x_pos= background.width_margin + ((mech.boxs.get(index4).x+1) * box.box_size);
                array_rows[mech.boxs.get(index4).y][mech.boxs.get(index4).x]=1;
                break;
              } // end inner if
            } // end for
          } // end mid if
        } // else there is no box blocking the path
        else
        {
          character.c_x_pos += (character.right - character.left) * 2*game_speed;
        }
      } // end inner if
    } // end mid if
  } // end outer if
  else  
  {
    // going left
    if(character.right - character.left < 0)
    {
      // Not at the limit
      if(character.c_x_pos> background.width_margin + character.c_size)
      {
        // not on the first col
        if(character.c_x>1)
        {
          // There's a box blocking our path to the left
          if( array_rows[character.c_y][character.c_x-1] == 1)
          {  
            // There's a clear spot after the box to the left
            if(array_rows[character.c_y][character.c_x-2] == 0)
            {
              // Finding the box to move in the ArrayList and Array
              for(int index4=0; index4< mech.m_no_box; index4++)
              {
                // if the box from the boxs has the position we're looking for
                if(mech.boxs.get(index4).x == character.c_x-1 && mech.boxs.get(index4).y == character.c_y)
                {
                  array_rows[mech.boxs.get(index4).y][mech.boxs.get(index4).x]=0;
                  mech.boxs.get(index4).x= character.c_x-2;
                  mech.boxs.get(index4).x_pos= background.width_margin + ((mech.boxs.get(index4).x+1) * box.box_size);
                  array_rows[mech.boxs.get(index4).y][mech.boxs.get(index4).x]=1;
                  break;
                } // end inner if
              } // end for
            }// End if clear spot after box (left)
          } 
          else // else there is no box blocking our path
          {
            character.c_x_pos += (character.right - character.left) * 2*game_speed;
          }
        } // end if not on first col
      } // end mid if
    } // end outer if
  } // end else
  
  if(character.c_y_pos < height-background.height_margin*2 - character.c_size + 4)
  {
    // Not the last line and not the first column
    if(character.c_y != background.vert_no_boxes - 1 && character.c_x != 0)
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
    }
  }
  else // marking the fact that the character will no longer keep falling
  {
    character.fall_cond=0;
  }
  
  /*   This checks if the array index corresponds with the real position.
       If it doesn't then it updates it
  */
  
  // If on the floor/bottom
  if( character.c_y == background.vert_no_boxes-1)
  {
    character.fall_cond=0;
    // if the position should be updated (to the right)
    if(character.c_x != (int) (character.c_x_pos - background.width_margin +10)/character.c_size)
    {
      character.c_x =(int) (character.c_x_pos - background.width_margin +10)/character.c_size; 
    }
    else
    {
      // if the position should be updated (to the left)
      if(character.c_x != (int) (character.c_x_pos - background.width_margin -10)/character.c_size)   character.c_x =(int) (character.c_x_pos - background.width_margin -10)/character.c_size; 
    }
  }
  else
  {
    // Not on the floor and check if it needs to be changed
    if((character.c_x != (int) (character.c_x_pos - background.width_margin + character.c_size )/character.c_size) )
    {
      character.c_x =(int) (character.c_x_pos - background.width_margin )/character.c_size; 
    }
  }
  
  // vertical
  if(character.c_y != (int) (character.c_y_pos - background.width_margin +28 )/character.c_size) character.c_y =(int) (character.c_y_pos - background.width_margin+28)/character.c_size;
}

void mouseClicked()
{
  // This is just a function that helps me understand where everything should be placed
  //println("x:"+mouseX+" y:"+ mouseY);
  character.c_x_pos= mouseX;
  character.c_y_pos=mouseY;
}

void keyPressed()
{
  
  if (keyCode == LEFT || key=='a')
  {
      character.left = 1;
  }

  if (keyCode == RIGHT || key=='d')
  {
    character.right = 1;
  }
  
} // end keyPressed

void keyReleased()
{
  
  if (keyCode == LEFT || key=='a')
  {
    character.left = 0;
  }
  
  if (keyCode == RIGHT || key=='d')
  {
    character.right = 0;
  }
  
}