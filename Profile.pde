class Profile
{
  
  Profile()
  {
  }
  
  void get_name()
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
    }
  }
} // end class Profile