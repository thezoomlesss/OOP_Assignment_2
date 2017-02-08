/* 
 Mohamad Zabad C15745405
 OPP Assignment 2
 
 */

// Minim library used for music
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

void setup()
{
  fullScreen();
  frameRate(60);
  background(0, 0, 17);

  // Doing this here because the setup runs before the Map class and we need those values initialised before we create the array
  background.grid_initial();
  array_rows=new int[background.vert_no_boxes][background.no_boxes];

  // The text sizes scale with your screen
  text_size = (int) (width * 0.021);
  title_size= (int) (width*0.042);

  // Importing the oft files for the fonts
  Title_font = createFont("Font1.otf", title_size);
  Text_font = createFont("Font2.otf", text_size); 
  Credit_font = createFont("Font3.otf", 34);


  /* 
   Loading and playing the music
   */
  minim = new Minim(this);
  song = minim.loadFile("songs/song"+song_index+".wav");  // this loads mysong.wav from the data/songs folder
  song.play();
  String path = "C:\\Users\\Mushy\\Documents\\GitHub\\OOP_Assignment_2" + "/data/songs"; // We use this so we can get the number of songs that we have in the songs folder
  File dataFolder = new File(path);
  fileList= dataFolder.list();
  song.setGain(-13); // The volume
}// end setup

/*
    Global declaration area
    These are variables that I share between the classes
 */
Minim minim;
AudioPlayer song;
String[] fileList;
int song_index=1, mech_count=0, mech_index, first_run=0;
int text_size, title_size;
int[][] array_rows;
int game_speed=2, state=0, score, cleared=0, clear_line_cond, mech_spawned=0;    // State starts from 0 because that's the first page
PFont Title_font, Text_font, Credit_font;


// Creating objects
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

void draw()
{
  setup_song();
  game_state(state); 
} // end draw


void game_state(int state) // The game state function
{
  switch(state)
  {
  case 0: // The screen where the user has to enter their name
    {
      profile.check_file();
      break;
    }
  case 1: // The main menu screen
    {
      menu.display();  // background
      menu.title();    // title
      menu.buttons();  // buttons
      break;
    }
  case 2: // The Leaderboards screen
    {
      profile.display();
      break;
    }
  case 3: // The Game screen
    {
      /*
          Everytime we press the new game button
          Everything will respawn
      */
      if (first_run==0)
      {
        // Giving the character two indexes for the position
        character.spawn_c((int)random(background.no_boxes *0.25, background.no_boxes *0.75), (int)random(background.vert_no_boxes *0.85, background.vert_no_boxes *0.90));
        
        // Spawning two mechs
        mech=new Mech();
        mech.spawn_m();
        mech=new Mech();
        mech.spawn_m();
        
        /*
            Spawning the boxes for the two mechs
            I have it in a for loop just so it's not hardcoded and ugly
        */
        for ( int mech_index=0; mech_index < mechs.size(); mech_index++)
        { 
          mechs.get(mech_index).spawn_box();
        }
        first_run=1; // marking that we passed through the first run so we don't have to re-initialise those objects
      }

      background.grid();   // Drawing the background
      background.score();  // Displaying the score on top of the character
      
      // For loop that goes through all the mechs
      for (mech_index=0; mech_index < mechs.size(); mech_index++)
      { 
        mechs.get(mech_index).draw_m();         // Drawing the mech
        mechs.get(mech_index).disp_boxs();     // Drawing the boxes
        mechs.get(mech_index).move_m();       // Calling the function that moves the mech around
      }
      
      // Drawing the character
      character.draw_c(character.move_box, character.c_x_pos, character.c_y_pos, character.c_size, character.c_colour);  
      update();            // Updating all the values that have to be updated every frame
      character.jump();    // Jumping until we get to the height of the original pos - the amount we want to jump by
      character.fall();    // Fall in case the user should actually fall
      character.c_move();  // This updates the position of the character
      
      // Going through the mech arraylist so we can access each boxs arraylist  ( each mech has it's own arraylist )
      for (mech_index=0; mech_index < mechs.size(); mech_index++)
      {
        mechs.get(mech_index).move_b();       // This updates the position of the boxes
      }          

      // 10 points for every second staying alive
      if (frameCount%60==1) score+=10;
      break;
    }
  case 4: // The Dead game screen
    {
      death.display(); // Simply stops the game and displays a new screen
      break;
    }
  case 5: // The Settings screen
    {
      settings.display(); // Background and all that is present on the screen
      break;
    }
  case 6: // The Instruction screen
    {
      instructions.display(); // Background and all that is present on the screen
      break;
    }
  case 7: // The credits screen
    {
      credit.display(); //Background and all that is present on the screen
      break;
    }

  default:   // Just in case 
    {
      background(0);
      textSize(text_size);
      text("Sorry Bud...", width * 0.40, height * 0.30);
    }
  } // end Switch
} // end of game_state


void setup_song()   // Function to get to the next song
{
  if (settings.toggle_music) // If we toggled that we want the music to play
  {
    if (!song.isPlaying())  // Song has ended
    {
      if (settings.playing) // If we reached this by listening to the whole song, not by toggling the pause music
      {
        // Next song
        song.rewind();
        song.close();
        song_index++;
        song = minim.loadFile("songs/song"+song_index+".wav");
        song.play();
        song.setGain(-13);
        // if at the last song then reset the index so the songs loop
        if (song_index > fileList.length - 1) song_index=1; 
      } else
      { 
        // Replay the music
        song.play();
        song.setGain(-13);
        settings.playing=true;
      }
    } else // if the song is not playing and 
    {
      song.play();
    }
  } // It's toggled to stop the music
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

  clear_line_cond=1; 

  // Checking if the last line of the array is full
  for (int index3=0; index3<background.no_boxes; index3++)
  {
    // If we find any position on the last line that is not occupied  then the condition is false
    if (array_rows[background.vert_no_boxes-1][index3]==0)
    {
      clear_line_cond=0;
    }
  } // end for loop that checks if the last line is not full
  
  // If we have to clear the last line
  if (clear_line_cond==1)
  {
    // removing from ArrayLists
    for (mech_index = 0; mech_index < mechs.size(); mech_index++)
    {
      // Each mech has a boxs arraylist that we have clear from
      for (int index3= mechs.get(mech_index).boxs.size()-1; index3>-1; index3--)
      {
        // if the box is on the last line then clear it
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
    cleared++;     // This is used so we can later spawn more mechs
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
  // If the cheats are toggled then allow teleportation
  if (state==3 && settings.cheats == true)
  {
    character.c_x_pos= mouseX;
    character.c_y_pos=mouseY;
  } else if (state==1) // if we are in the menu
  {
    // if we are between the width of the button box
    if (mouseX> width * 0.5f - menu.button_width && mouseX <width * 0.5f + menu.button_width) 
    {
      // if first button  (new game)
      if (mouseY> height * menu.pos  - menu.button_height && mouseY< height * menu.pos + menu.button_height)
      {
        score=0; 
        state=6; // it takes us to the instructions screen
      }// else if 2nd button (leaderboards) 
      else if ( mouseY> height * menu.pos + 3  * menu.button_height - menu.button_height && mouseY< height * menu.pos + 3  * menu.button_height + menu.button_height)
      {
        state=2;
        // Else if third button ( settings ) 
      } else if (mouseY> height * menu.pos + 6  * menu.button_height - menu.button_height && mouseY< height * menu.pos + 6  * menu.button_height + menu.button_height)
      {
        state=5;
      } 
    } // end if not between the width of the buttons 
          // If we are pressing the credits text
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
    
    // if pressing on the toggle cheats button
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
    // If on credits screen
  } else if (state==7)
  {
    //if pressing the back button
    if (mouseX> width * 0.45 && mouseX < width * 0.55 && mouseY > height * 0.85 && mouseY< height * 0.95) 
    {
      state=1;
    }
  } // end if on credits
} // end mouseClicked

void keyPressed()
{
  if (state==3) // if on the game screen
  {
    if ( key=='f' ) // togle push/climb mode
    {
      character.move_box= !character.move_box;
    }

    if ( key=='a' )
    {
      character.left = 1;
      character.angle_left=true; // rotation counter clockwise for the character
    }

    if ( key=='d')
    {
      character.right = 1;
      character.angle_right=true; // rotation clockwise for the character
    }
    
    // If we pressed 'w' and we are allowed to jump and we have already realeased the last 'w' press and we are not falling (we are on solid ground)
    if ( key=='w' && character.jump_cond==true && character.up_released == true && character.fall_cond == 0  ) 
    {

      character.old_pos= character.c_y_pos; // taking the pos before the jump
      character.fall_cond=1;               // making this true just so we can't jump again while in mid air
      character.up=1;                     // signaling that the character should go up
      character.up_released=false;       // Again another condition for double jumps
      character.jump_cond=false;        // Yes, I do need all these conditions ( at least in the way that I did it ) 
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