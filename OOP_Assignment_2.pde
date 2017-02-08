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
 - Add losing the game
 - Add more mechs
 - Add the score
 - Fix the jump physics
 - Finish the Instructions page
 - Add the interface
 - Add credits
 - Add a function in design for the titles
 */

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

void setup()
{
  fullScreen();
  frameRate(120);
  background(0, 0, 17);
  // Doing this here because the setup runs before the Map class and we need those values initialised before we create the array
  background.grid_initial();
  array_rows=new int[background.vert_no_boxes][background.no_boxes];

  text_size = (int) (width * 0.021);
  title_size= (int) (width*0.042);

  Title_font = createFont("Font1.otf", title_size);
  Text_font = createFont("Font2.otf", text_size); 
  Credit_font = createFont("Font3.otf", 34);



  minim = new Minim(this);
  // this loads mysong.wav from the data folder
  song = minim.loadFile("songs/song"+song_index+".wav");
  song.play();
  // We use this so we can get the number of songs that we have in the songs folder
  String path = "C:\\Users\\Mushy\\Documents\\GitHub\\OOP_Assignment_2" + "/data/songs";
  File dataFolder = new File(path);
  fileList= dataFolder.list();
  song.setGain(-13);
}// end setup

// Global declaration area
Minim minim;
AudioPlayer song;
String[] fileList;
int song_index=1, mech_count=0, mech_index, first_run=0;
int text_size, title_size;
int[][] array_rows;
int game_speed=2, state=0, score, cleared=0, mech_spawned=0;    // State starts from 0 because that's the first page
PFont Title_font, Text_font, Credit_font;
//int deleted;

// Creating the objects that will be added into the ArrayLists
Map background=new Map();
Box box= new Box();
Mech mech= new Mech();
Char character= new Char();
Profile profile= new Profile();           
Menu menu= new Menu();
Settings settings= new Settings();
Death death= new Death();
Instructions instructions= new Instructions();
Credits credit= new Credits();

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
      menu.display();
      menu.title();
      menu.buttons();
      break;
    }
  case 2: // Leaderboards screen
    {
      profile.display();
      break;
    }
  case 3: // Game screen
    {
      // Remember to add all the things from the setup

      // These 3 have to be moved 
      if (first_run==0)
      {
        character.spawn_c((int)random(background.no_boxes *0.25, background.no_boxes *0.75), (int)random(background.vert_no_boxes *0.85, background.vert_no_boxes *0.90));

        mech=new Mech();
        mech.spawn_m();
        mech=new Mech();
        mech.spawn_m();

        for ( int mech_index=0; mech_index < mechs.size(); mech_index++)
        { 
          mechs.get(mech_index).spawn_box();
        }
        first_run=1;
      }



      background.grid();   // Drawing the background
      background.score();
      for (mech_index=0; mech_index < mechs.size(); mech_index++)
      { 
        mechs.get(mech_index).draw_m();       // Drawing the mech
        mechs.get(mech_index).disp_boxs();   // Drawing the boxes
        mechs.get(mech_index).move_m();       // Calling the function that moves the mech around
      }
      character.draw_c(character.move_box, character.c_x_pos, character.c_y_pos, character.c_size, character.c_colour);  // Drawing the character
      update();            // Updating all the values
      character.jump();    // Jumping until we get to the height of the original pos - the amount we want to jump by
      character.fall();

      /*
          Update for character's position
       We check the places next to the character to see if they're free
       for left we have an -1 because the index we use is already greater than the actual position by one
       */
      character.c_move();  // This updates the position of the character
      for (mech_index=0; mech_index < mechs.size(); mech_index++)
      {
        mechs.get(mech_index).move_b();       // This updates the position of the boxes
      }          
      
      // 10 points for every second staying alive
      if (frameCount%60==1) score+=10;
      break;
    }
  case 4: // Dead game screen
    {
      death.display();
      break;
    }
  case 5: // settings 
    {
      settings.display();
      break;
    }
  case 6: // Instruction screen
    {
      instructions.display();
      break;
    }
  case 7: // The credits screen
    {
      credit.display();
      break;
    }

  default:
    {
      textSize(text_size);
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
  if (settings.toggle_music)
  {
    if (!song.isPlaying())
    {
      if ( settings.playing)
      {
        song.rewind();
        song.close();
        song_index++;
        song = minim.loadFile("songs/song"+song_index+".wav");
        song.play();
        song.setGain(-13);
        if (song_index > fileList.length - 1) song_index=1;
      } else
      {
        //song.rewind();
        song.play();
        song.setGain(-13);
        settings.playing=true;
      }
    } else
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
  for (int index3=0; index3<background.no_boxes; index3++)
  {
    if (array_rows[background.vert_no_boxes-1][index3]==0)
    {
      clear_line_cond=0;
    }
  } // end for loop that checks if the last line is full

  if (clear_line_cond==1)
  {
    // removing from ArrayList

    for (mech_index = 0; mech_index < mechs.size(); mech_index++)
    {
      for (int index3= mechs.get(mech_index).boxs.size()-1; index3>-1; index3--)
      {
        if (mechs.get(mech_index).boxs.get(index3).y== background.vert_no_boxes-1)
        {
          mechs.get(mech_index).boxs.remove(index3);
          mechs.get(mech_index).m_no_box--;
        }
      } // end for that removes the boxes from the ArrayList
    }


    //Removing from array  No real reason why I'm going backwards
    for (int index3=background.no_boxes-1; index3>-1; index3--)
    {
      array_rows[background.vert_no_boxes-1][index3]=0;
    }  
    cleared++;
    score+=1000;
  }// end if clear_line_cond==1 


  /*
      Addinng more mechs when we clear lines
   initially add every 2 clears
   then we do it after 3 clears
   at the end we do it after 6 clears
   
   We do this so the screen doesn't get overcrowded and the game doesn't become impossible
   */

  if ( cleared <5)
  {
    if ( cleared % 2 == 0 && mech_spawned!=cleared)
    {
      mech=new Mech();
      mech.spawn_m();
      mech_spawned = cleared;
    }
  } else if ( cleared < 13)
  {
    if ( cleared % 3 == 0 && mech_spawned!=cleared)
    {
      mech=new Mech();
      mech.spawn_m();
      mech_spawned = cleared;
    }
  } else
  {
    if ( cleared % 6 == 0 && mech_spawned!=cleared)
    {
      mech=new Mech();
      mech.spawn_m();
      mech_spawned = cleared;
    }
  }
} // end update

void mouseClicked()
{
  // This is just a function that helps me understand where everything should be placed
  //println("x:"+mouseX+" y:"+ mouseY);
  if (state==3 && settings.cheats == true)
  {
    character.c_x_pos= mouseX;
    character.c_y_pos=mouseY;
  } else if (state==1)
  {
    if (mouseX> width * 0.5f - menu.button_width && mouseX <width * 0.5f + menu.button_width) 
    {
      // if first button  (new game)
      if (mouseY> height * menu.pos  - menu.button_height && mouseY< height * menu.pos + menu.button_height)
      {
        score=0;
        state=6;
      }// else if 2nd button (leaderboards) 
      else if ( mouseY> height * menu.pos + 3  * menu.button_height - menu.button_height && mouseY< height * menu.pos + 3  * menu.button_height + menu.button_height)
      {
        state=2;
      } else if (mouseY> height * menu.pos + 6  * menu.button_height - menu.button_height && mouseY< height * menu.pos + 6  * menu.button_height + menu.button_height)
      {
        state=5;
      } // if pressing on credits
    } // end if not between the width of the buttons
    else if ( mouseY> height *0.93 && mouseY< height *0.96  && mouseX> width * 0.91 && mouseX< width * 0.95)
    {
      state=7;
    }
  } // end if not on the menu page
  else if (state==2) // if on the leaderboards page and pressing the back button
  {
    if (mouseX> width * 0.45 && mouseX < width * 0.55 && mouseY > height * 0.85 && mouseY< height * 0.95) 
    {
      state=1;
    }
  } // if on the seetings page
  else if (state==5)
  {
    // if pressing on the toggle music button
    if ( mouseX > width * 0.58 - settings.check_size/2 && mouseX < width * 0.58 + settings.check_size/2 && mouseY > height *0.39 - settings.check_size/2 && mouseY < height * 0.39 + settings.check_size/2)
    {
      settings.toggle_music = !settings.toggle_music;
      settings.playing=false;
    } 
    if ( mouseX > width * 0.58 - settings.check_size/2 && mouseX < width * 0.58 + settings.check_size/2 && mouseY > height *0.49 - settings.check_size/2 && mouseY < height * 0.49 + settings.check_size/2)
    {
      settings.cheats=!settings.cheats;
    } 

    //if pressing the back button
    if (mouseX> width * 0.45 && mouseX < width * 0.55 && mouseY > height * 0.85 && mouseY< height * 0.95) 
    {
      state=1;
    }
  } // if on the death screen
  else if (state==4)
  {
    //if pressing the back button
    if (mouseX> width * 0.45 && mouseX < width * 0.55 && mouseY > height * 0.85 && mouseY< height * 0.95) 
    {
      // Saving the score
      profile.save_score(profile.name, score);

      // Clearing the mechs
      for (int index= mechs.size()-1; index>=0; index--)
      {
        // Clearing the boxs arraylists
        for (int index2= mechs.get(index).boxs.size() - 1; index2 >= 0; index2--)
        {
          mechs.get(index).boxs.remove(index2);
        }
        mechs.get(index).m_no_box=0;
        mechs.remove(index);
      }

      // Clearing the array rows when we reset the game
      for (int index3=0; index3 < background.no_boxes; index3++)
      {
        for (int index4=0; index4 < background.vert_no_boxes; index4++)
        {
          array_rows[index4][index3]=0;
        }
      }  

      first_run=0;
      state=1;
    }
  }// end else if on settings
  else if (state==6)
  {
    //if pressing the back button
    if (mouseX> width * 0.45 && mouseX < width * 0.55 && mouseY > height * 0.85 && mouseY< height * 0.95) 
    {
      state=1;
    }
    //if pressing the start button
    if (mouseX> width * 0.45 && mouseX < width * 0.55 && mouseY > height * 0.73 && mouseY< height * 0.83) 
    {
      state=3;
    }
  } else if (state==7)
  {
    //if pressing the back button
    if (mouseX> width * 0.45 && mouseX < width * 0.55 && mouseY > height * 0.85 && mouseY< height * 0.95) 
    {
      state=1;
    }
  }
} // end mouseClicked

void keyPressed()
{
  if (state==3)
  {
    if ( key=='f' )
    {
      character.move_box= !character.move_box;
    }

    if ( key=='a' )
    {
      character.left = 1;
      character.angle_left=true;
    }

    if ( key=='d')
    {
      character.right = 1;
      character.angle_right=true;
    }
    if ( key=='w' && character.jump_cond==true && character.up_released == true && character.fall_cond == 0  ) 
    {

      character.old_pos= character.c_y_pos;
      character.fall_cond=1;
      character.up=1;
      character.up_released=false;
      character.jump_cond=false;
    }
  }
} // end keyPressed

void keyReleased()
{
  if (state==3)
  {
    if ( key=='a')
    {
      character.left = 0;
      character.angle_left=false;
    }

    if ( key=='d')
    {
      character.right = 0;
      character.angle_right=false;
    }

    if ( key=='w')
    {
      character.up_released=true;
    }
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