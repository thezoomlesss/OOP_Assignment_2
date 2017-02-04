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
  
  Left to do:
  - Fix how the position index works
  - Fix box pushing
  - Add more mechs
  - Add the score
  - Fix the jump physics
  
*/

import ddf.minim.*;

void setup()
{
  fullScreen();
  frameRate(120);
  background(0,0,17);
  // Doing this here because the setup runs before the Map class and we need those values initialised before we create the array
  background.grid_initial();
  array_rows=new int[background.vert_no_boxes][background.no_boxes];
  
  // These 3 have to be moved 
  character.spawn_c((int)random(background.no_boxes *0.25, background.no_boxes *0.75) , (int)random(background.vert_no_boxes *0.85, background.vert_no_boxes *0.90));
  
  mech=new Mech();
  mech.spawn_m();
  mech=new Mech();
  mech.spawn_m();
  
  for( int mech_index=0; mech_index < mechs.size(); mech_index++)
  { 
    mechs.get(mech_index).spawn_box();
  }
  Title_font = createFont("Font1.otf", 34);
  Text_font = createFont("Font2.otf", 34); 
  
  
  minim = new Minim(this);
  // this loads mysong.wav from the data folder
  song = minim.loadFile("songs/song"+song_index+".wav");
  song.play();
  // We use this so we can get the number of songs that we have in the songs folder
  String path = "C:\\Users\\Mushy\\Documents\\GitHub\\OOP_Assignment_2" + "/data/songs";
  File dataFolder = new File(path);
  fileList= dataFolder.list();
  
  
}// end setup

// Global declaration area
Minim minim;
AudioPlayer song;
String[] fileList;
int song_index=1, mech_count=0, mech_index;
int[][] array_rows;
int game_speed=2, state=0, score;    // State starts from 0 because that's the first page
PFont Title_font, Text_font;
//int deleted;

// Creating the objects that will be added into the ArrayLists
Map background=new Map();
Box box= new Box();
Mech mech= new Mech();
Char character= new Char();
Profile profile= new Profile();           
Menu menu= new Menu();
Settings settings= new Settings();

// ArrayLists
ArrayList <Box> boxes= new ArrayList <Box>();
ArrayList <Mech> mechs= new ArrayList <Mech>();

void game_state(int state)
{
  switch(state)
  {
    case 0: // Name screen
    {
      profile.check_file();
      break;
    }
    case 1: // Main menu screen
    {
      menu.display_border();
      menu.title();
      menu.buttons();
      break;
    }
    case 2: // Leaderboards screen
    {
      profile.top_10();
      break;
    }
    case 3: // Game screen
    {
      // Remember to add all the things from the setup
      
      background.grid();   // Drawing the background
      for(mech_index=0; mech_index < mechs.size(); mech_index++)
      { 
        mechs.get(mech_index).draw_m();       // Drawing the mech
        mechs.get(mech_index).disp_boxes();   // Drawing the boxes
        mechs.get(mech_index).move_m();       // Calling the function that moves the mech around   
      }
      character.draw_c();  // Drawing the character
      update();            // Updating all the values
      character.jump();    // Jumping until we get to the height of the original pos - the amount we want to jump by
      
      /*
          Update for character's position
          We check the places next to the character to see if they're free
          for left we have an -1 because the index we use is already greater than the actual position by one
      */
      character.c_move();  // This updates the position of the character
      for(mech_index=0; mech_index < mechs.size(); mech_index++)
      {
        mechs.get(mech_index).move_b();       // This updates the position of the boxes
      }          
 
  
      break;
    }
    case 4: // Dead game screen
    {
      profile.save_score(profile.name, score);
      break;
    }
    case 5: // settings 
    {
      settings.s_menu();
      break;
    }
    
    default:
    {
      textSize(40);
      text("Sorry Bud...", width * 0.40, height * 0.30);
    }
    
  } // end Switch
}


void draw()
{
  //println(frameRate);
  setup_song();
  game_state(state); 
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
} // end draw


void setup_song()   // Function to get to the next song
{
  if(settings.toggle_music)
  {
    if(!song.isPlaying())
    {
      if( settings.playing)
      {
        song.rewind();
        song.close();
        song_index++;
        song = minim.loadFile("songs/song"+song_index+".wav");
        song.play();
        if(song_index > fileList.length - 1) song_index=1;
      }
      else
      {
        //song.rewind();
        song.play();
        settings.playing=true;
      }
    }
    else
    {
      song.play();
    }
  } // stop music
  else
  {
    song.pause();
  }
} // end setup_song


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
    if(array_rows[background.vert_no_boxes-1][index3]==0)
    {
      clear_line_cond=0;
    }
  } // end for loop that checks if the last line is full
  
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
    } // end for that removes the boxes from the ArrayList
    
    //Removing from array  No real reason why I'm going backwards
    for(int index3=background.no_boxes-1; index3>-1; index3--)
    {
      array_rows[background.vert_no_boxes-1][index3]=0;
      //deleted=1;
    }  
  }// end if
  
  /*   This checks if the array index corresponds with the real position.
       If it doesn't then it updates it
  */
  
  textSize(20);
  text("Character pos x "+character.c_x, 300,400);
  /*
  
  if(character.c_x_pos +  character.c_size * 0.5 > background.width_margin + ((character.c_x + 1)  * character.c_size) )
  {
    if(array_rows[character.c_y][character.c_x+1]!=1) character.c_x++;
  }
  else
  {
    if(character.c_x_pos +  character.c_size * 0.5 < background.width_margin + ((character.c_x )  * character.c_size) )
    {
      if(array_rows[character.c_y][character.c_x-1]!=1) character.c_x--;
    }
  }
  
  line(character.c_x_pos + character.c_size *0.5, character.c_y_pos, character.c_x_pos + character.c_size *0.5, character.c_y_pos + character.c_size);
  
  
  */
  
  
  /*
             This somewhat works fine
  
 */
  if(character.c_x_pos > background.width_margin + (character.c_x * character.c_size) + character.c_size * 0.5)
  {
    character.c_x++;
  }
  else
  {
    if(character.c_x_pos < background.width_margin + (character.c_x * character.c_size) - character.c_size * 0.5)
    {
      character.c_x--;
    }
  }
  
  // The line drawn on the character
  stroke(255,0,0);
  line(background.width_margin + (character.c_x * character.c_size) + character.c_size * 0.5, character.c_y_pos, background.width_margin + (character.c_x * character.c_size) + character.c_size * 0.5, character.c_y_pos+ character.c_size);
  
  

 
             
  /*
  
  // If on the floor/bottom
  if( character.c_y == background.vert_no_boxes-1)
  {
    character.fall_cond=0;
    // if the position should be updated (to the right)
    if(character.c_x != (int) (character.c_x_pos - background.width_margin +10)/character.c_size)
    {
      character.c_x =(int) (character.c_x_pos - background.width_margin +10)/character.c_size; 
      text("Right to: "+character.c_x, 300,450); 
    }
    else
    {
      // if the position should be updated (to the left)
      if(character.c_x != (int) (character.c_x_pos - background.width_margin -10)/character.c_size)
      {
        character.c_x =(int) (character.c_x_pos - background.width_margin -10)/character.c_size;
        text("Left to: "+character.c_x, 300,450);
      }
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
  
  */
  text(character.c_y, 300,300);
  
} // end update

void mouseClicked()
{
  // This is just a function that helps me understand where everything should be placed
  //println("x:"+mouseX+" y:"+ mouseY);
  if(state==3)
  {
    character.c_x_pos= mouseX;
    character.c_y_pos=mouseY;
  }
  else if(state==1)
       {
          if(mouseX> width * 0.5f - menu.button_width && mouseX <width * 0.5f + menu.button_width) 
          {
            // if first button  (new game)
            if(mouseY> height * menu.pos  - menu.button_height && mouseY< height * menu.pos + menu.button_height)
            {
              score=0;
              state=3;
            }
            // else if 2nd button (leaderboards) 
            else if( mouseY> height * menu.pos + 3  * menu.button_height - menu.button_height && mouseY< height * menu.pos + 3  * menu.button_height + menu.button_height)
            {
              state=2;
            }
            else if(mouseY> height * menu.pos + 6  * menu.button_height - menu.button_height && mouseY< height * menu.pos + 6  * menu.button_height + menu.button_height)
            {
              state=5;
            }
          } // end if not between the width of the buttons 
       } // end if not on the menu page
       else if(state==2) // if on the leaderboards page and pressing the back button
       {
         if(mouseX> width * 0.45 && mouseX < width * 0.55 && mouseY > height * 0.85 && mouseY< height * 0.95) 
         {
            state=1;
         }
       } // if on the seetings page
       else if(state==5)
       {
         // if pressing on the toggle music button
         if( mouseX > width * 0.58 - settings.check_size/2 && mouseX < width * 0.58 + settings.check_size/2 && mouseY > height *0.39 - settings.check_size/2 && mouseY < height * 0.39 + settings.check_size/2)
         {
           settings.toggle_music = !settings.toggle_music;
           settings.playing=false;
         } 
         
         //if pressing the back button
         if(mouseX> width * 0.45 && mouseX < width * 0.55 && mouseY > height * 0.85 && mouseY< height * 0.95) 
         {
            state=1;
         }
       } // end else if on settings
    
} // end mouseClicked

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
  
  if(keyCode == UP || key=='w' && character.jump_cond==true && character.up_released == true )  // find a way to add && character.fall_cond != 1 cause it doesn't work
  {
    character.old_pos= character.c_y_pos;
    character.fall_cond=0;
    character.up=1;
    character.up_released=false;
    character.jump_cond=false;
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
  
  if (keyCode == UP || key=='w')
  {
    character.up_released=true;
  }  
} // end keyReleased

/*
    Function used to write with white color font with a black outline
*/
void strokeText(String message, float x, float y) 
{ 
  fill(0); 
  text(message, x-1, y); 
  text(message, x, y-1); 
  text(message, x+1, y); 
  text(message, x, y+1); 
  fill(255); 
  text(message, x, y); 
} // end strokeText