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
  fullScreen(P2D);
  background(0,0,13);
  int[][] array_rows=new int[(int)background.no_boxes][(int)background.no_vert_lines];
}

// Global declaration area


Map background=new Map();
Machine mech= new Machine(60, 60);
void draw()
{
  background.grid();
  mech.disp();
}

void mouseClicked()
{
  // This is just a function that helps me understand where everything should be placed
  //println("x:"+mouseX+" y:"+ mouseY);
}