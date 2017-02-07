class Profile extends Design
{
  Table table2; 
  int rowCount2;
  String allowed_chars="qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM ";
  String name="";
  int name_index=0;
  Record[] order=new Record[10];  // We are using 11 because we are doing a top 10 and the 11th position will be used as a temp position
  Record order_temp= new Record("Temp", 1);


  void top_10()
  {
    backgr();
    sort();
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
    if (rowCount==0)
    {
      strokeText("No records available yet", width * 0.5, height * 0.2);
    } else // if we have records
    {
      // If the results >10 (the result should be at max 10 normally)
      if (rowCount>10) rowCount=10;

      // The box
      strokeWeight(4);
      fill(10, 8, 25);
      beginShape();
      vertex( width * 0.3, height *  0.11);
      vertex( width * 0.3, height * (rowCount+3) * 0.062);
      vertex( width * 0.7, height * (rowCount+3) * 0.062);
      vertex( width * 0.7, height  * 0.11);
      endShape(CLOSE);

      strokeWeight(2); 
      fill(255);

      // The names and scores
      for (int i = 0; i < rowCount; i++)
      {
        one= new Record(table.getString(i, 0), table.getInt(i, 1));
        strokeText(one.name, width * 0.43, height * (i+3) * 0.061);
        strokeText(String.valueOf(one.score), width * 0.57, height * (i+3) * 0.061);
      }
    }// end else


    button("Back", 0.85, 0.95);
  }

  void get_name()
  {
    backgr();

    // Use string.indexOf('a') for the permitted characters

    // The title
    textAlign(CENTER);
    textFont(Title_font);
    textSize(100);
    strokeText("Choose your name", width * 0.5, height *0.2);

    // The name box
    fill(10, 8, 25);
    beginShape();
    vertex(width * 0.5 - 195, height * 0.45);
    vertex(width * 0.5 + 195, height * 0.45);   // Using - 195 so it looks the same on any screen
    vertex(width * 0.5 + 195, height * 0.55);
    vertex(width * 0.5 - 195, height * 0.55);
    endShape(CLOSE);


    // Taking the character input
    if (keyPressed && (name_index<12 || key==ENTER))
    {

      delay(200);
      if (key!=BACKSPACE && key!=ENTER)// && allowed_chars.indexOf(key) > 0)
      {
        name+=Character.toUpperCase(key);
        name_index++;
      }
      if (key==ENTER && name_index>0) 
      {

        state=1;
      }

      if (key==BACKSPACE && name_index>0)  
      {
        delay(200);
        name_index--;
        name=name.substring(0, name.length()-1);
      }
    } else
    {
      if (key==BACKSPACE && name_index==12)  
      {
        delay(200);
        name_index--;
        name=name.substring(0, name.length()-1);
      }
    }

    // Displaying the characters
    textFont(Text_font);
    textSize(40);
    textAlign(CENTER);
    strokeText(name, width *0.5, height * 0.51);
  }




  void save_score(String name, int score)
  {

    sort();
    /* 
     Here we determine which position the new score should go on
     We update the array
     We update the text file with the new array
     */
    int index_score = rowCount2-1;

    // In case the text file is empty thins prevents a crash   
    if ( rowCount2 != 0 )
      while (score > order[index_score].score)
      {
        index_score--;
        if (index_score==0) break;
      }

    // Checking that the position we want to put in exists in the array
    if (index_score >= 0 && index_score != rowCount2-1)
    {
      // inserting the new score into the array
      for (int index=index_score; index < rowCount2; index++)
      {

        order_temp.name = order[index].name ;
        order_temp.score = order[index].score;

        order[index].name = name;
        order[index].score = score;

        name=order_temp.name;
        score=order_temp.score;
      } // end for used to add the new score in
    } 

    PrintWriter leader_txt;   
    leader_txt = createWriter(dataPath("Leaderboards.txt"));

    for (int index=0; index<rowCount2; index++)
    {
      leader_txt.println(order[index].name+ "\t"+ order[index].score);
    }
    leader_txt.close();
  }// end save_score


  void sort()
  { 
    table2 = loadTable("Leaderboards.txt", "tsv");
    rowCount2 = table2.getRowCount();
    // Getting the data into our array
    for (int index=0; index<rowCount2; index++)
    {
      if (index==10) break;
      order[index]=new Record(table2.getString(index, 0), table2.getInt(index, 1));
    }

    /* 
     Using bubble sort to sort the little array before writing it into the file
     */
    for (int i = 0; i < rowCount2-1; i++) 
    {
      for (int j = 1; j < (rowCount2 - i); j++) 
      {
        if (j==10) break;
        if (order[j - 1].score < order[j].score) 
        {
          //println(order[index-1].name, order[index-1].score + " Swapped with " + order[index].name, order[index].score);
          order_temp.name = order[j-1].name;
          order_temp.score = order[j-1].score;

          order[j-1].name = order[j].name;
          order[j-1].score = order[j].score;

          order[j].name = order_temp.name;
          order[j].score = order_temp.score;
        }
      } // end inner for
    } // end outer for

    // writing the sorted array into the file
    PrintWriter leader_txt;   
    leader_txt = createWriter(dataPath("Leaderboards.txt"));

    for (int index=0; index<rowCount2; index++)
    {
      if (index==10) break;
      leader_txt.println(order[index].name+ "\t"+ order[index].score);
    }
    leader_txt.close();
  }


  void check_file()
  {
    File f = new File(dataPath("Leaderboards.txt")); 
    if (!f.exists())
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