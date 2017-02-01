class Profile
{
                 /*
                       Missing a page for the leaderboards
                 */
  void top_10()
  {
    // The button works
    menu.display_border();
    Table table = loadTable("Leaderboards.txt", "tsv");
    Record one;
     
    int rowCount = table.getRowCount();   
    textSize(20);
    textAlign(CENTER);
    textFont(Title_font);
    strokeText("Top 10", width * 0.5, height *0.1);
    
    for(int i = 0; i < rowCount; i++)
    {
      one= new Record(table.getString(i,0), table.getInt(i,1));
      strokeText(one.name, width * 0.4, height * (i+2) * 0.1);
      strokeText(String.valueOf(one.score), width * 0.6,  height * (i+2) * 0.1);
      if(i==10) break;
    }
  }
  
  void get_name()
  {
    
  }
  
  void save_score(String name, int score)
  {
    
  }
  
  void check_file()
  {
    File f = new File(dataPath("Leaderboards.txt")); 
    if(f.exists())
    {
      // The file exists
      state=1;
    }
    else
    {
      // The file doesn't exist and we have to create it
      
      PrintWriter profile_txt;   
      profile_txt = createWriter(dataPath("Leaderboards.txt"));
      profile_txt.close();
      state=1;
    } // end else
    
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