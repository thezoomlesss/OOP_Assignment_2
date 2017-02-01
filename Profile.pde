class Profile
{
  String allowed_chars="qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM ";
  String name="";
  int name_index=0;
  
  
  void top_10()
  {
    menu.display_border();
    Table table = loadTable("Leaderboards.txt", "tsv");
    Record one;
    int rowCount = table.getRowCount();   
    
    // The title
    textSize(30);
    textAlign(CENTER);
    textFont(Title_font);
    strokeText("T o p  1 0", width * 0.5, height *0.08);
    
    
    textSize(20);
    textFont(Text_font);
    // If there is no record available  yet
    if(rowCount==0)
    {
      strokeText("No records available yet", width * 0.5, height * 0.2);
    }
    else // if we have records
    {
      // If the results >10 (the result should be at max 10 normally)
      if(rowCount>10) rowCount=10;
      
      // The box
      strokeWeight(4);
      fill(10,8,25);
      beginShape();
      vertex( width * 0.3, height *  0.11);
      vertex( width * 0.3, height * rowCount * 0.077);
      vertex( width * 0.7, height * rowCount * 0.077);
      vertex( width * 0.7, height  * 0.11);
      endShape(CLOSE);
      
      strokeWeight(2); 
      fill(255);
      
      // The names and scores
      for(int i = 0; i < rowCount; i++)
      {
        one= new Record(table.getString(i,0), table.getInt(i,1));
        strokeText(one.name, width * 0.43,  height * (i+3) * 0.061);
        strokeText(String.valueOf(one.score), width * 0.57,   height * (i+3) * 0.061);
      }
    }// end else
    
    // The back button
    
    if(mouseX> width * 0.45 && mouseX < width * 0.55 && mouseY > height * 0.81 && mouseY< height * 0.91)
    {
      fill(0,55,205); // Hovered color
      stroke(15,25,50);
      strokeWeight(6);
    }
    else
    {
      fill(10,8,25); // Not hovered
      strokeWeight(4);
      stroke(25,45,120); 
    }
    beginShape();
    vertex(width * 0.45, height * 0.81);
    vertex(width * 0.45, height * 0.91);
    vertex(width * 0.55, height * 0.91);
    vertex(width * 0.55, height * 0.81);
    endShape(CLOSE);
    
    textAlign(CENTER);
    strokeText("Back", width * 0.5, height * 0.87);
    
  }
  
  void get_name()
  {
    menu.display_border(); 
    
    // Use string.indexOf('a') for the permitted characters
    
    // The title
    textAlign(CENTER);
    textFont(Title_font);
    textSize(100);
    strokeText("Choose your name", width * 0.5, height *0.2);
    
    // The name box
    fill(10,8,25);
    beginShape();
    vertex(width * 0.4, height * 0.45);
    vertex(width * 0.6, height * 0.45);
    vertex(width * 0.6, height * 0.55);
    vertex(width * 0.4, height * 0.55);
    endShape(CLOSE);
    
    
    // Taking the character input
    if(keyPressed && (name_index<12 || key==ENTER))
    {
      
      delay(200);
      if(key!=BACKSPACE && key!=ENTER)// && allowed_chars.indexOf(key) > 0)
      {
        name+=Character.toUpperCase(key);
        name_index++;
      }
      if(key==ENTER && name_index>0) 
      {
            
        state=1;         
        
      }
      
      if(key==BACKSPACE && name_index>0)  
      {
        delay(200);
        name_index--;
        name=name.substring(0,name.length()-1);
      }
    }
    else
    {
      if(key==BACKSPACE && name_index==12)  
      {
        delay(200);
        name_index--;
        name=name.substring(0,name.length()-1);
      }
    }
    
    // Displaying the characters
    textFont(Text_font);
    textSize(40);
    textAlign(CENTER);
    strokeText(name, width *0.5,height * 0.51);
    
  }
  
  void save_score(String name, int score)
  {
    
  }
  
  void check_file()
  {
    File f = new File(dataPath("Leaderboards.txt")); 
    if(!f.exists())
    {
      // The file doesn't exist and we have to create it
      
      PrintWriter profile_txt;   
      profile_txt = createWriter(dataPath("Leaderboards.txt"));
      profile_txt.close();
    } // end else
    
    profile.get_name();
    
  } // end check_file()
  
} // end class Profile

class Record
{
  String name;
  int score;
  
  Record(String name, int score)
  {
    this.name=name;
    this.score=score;
  } // end constructor
  
} // end class Record