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
  background(0,0,17);
  // Doing this here because the setup runs before the Map class and we need those values initialised before we create the array
  background.grid_initial();
  array_rows=new int[background.no_boxes][background.vert_no_boxes];
  /*
      Initializing the array with 0 because we don't have any boxes yet
  */
 
  for(int index2=0; index2<background.vert_no_boxes; index2++)
  {
     for(int index1=0; index1<background.no_boxes; index1++)
    {
      array_rows[index1][index2]=0;
    }
  }
  mech.spawn_m();
  mech.spawn_box();
}

// Global declaration area
int[][] array_rows;
int game_speed=4;

// Creating the objects that will be added into the ArrayLists
Map background=new Map();
Box box= new Box();
Mech mech= new Mech();

// ArrayLists
ArrayList <Box> boxes= new ArrayList <Box>();
ArrayList <Mech> mechs= new ArrayList <Mech>();

void draw()
{
  background.grid();
  mech.draw_m();
  for(int index2=0; index2 < mech.boxs.size(); index2++)
  {
    mech.boxs.get(index2).disp();
  }
  update();
  
  
  /*
         Don't mind this
         It's just a test
         
         
  println(background.vert_no_boxes, background.no_boxes);
  for(int index2=0; index2<background.vert_no_boxes; index2++)
  {
    for(int index1=0; index1<background.no_boxes; index1++)
    {  
      print(array_rows[index1][index2]+" ");
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
  
  // Checking if the last line of the array is full
  for(int index3=0; index3<background.no_boxes; index3++)
  {
    if(array_rows[index3][background.vert_no_boxes-1]==0)
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
    
    //Removing from array
    for(int index3=background.no_boxes-1; index3>-1; index3--)
    {
      println("TRUE");
      array_rows[index3][background.vert_no_boxes-1]=0;
    }  
  }// end if
  
  mech.move_m();
  
  // Moving all the boxes that are in the arraylist boxs
  for(int index2=0; index2 < mech.boxs.size(); index2++)
  {
    mech.boxs.get(index2).move_b();
  }
}

void mouseClicked()
{
  // This is just a function that helps me understand where everything should be placed
  //println("x:"+mouseX+" y:"+ mouseY);
}