class Settings extends Design
{
  boolean toggle_music=true, playing=true, cheats;
  int check_size= 30;

  void s_menu()
  {
    backgr();
    textAlign(CENTER);

    // The title

    textFont(Title_font);
    textSize(80);
    strokeText("Settings", width * 0.5, height * 0.1);

    // The text for Music
    textFont(Text_font);
    textSize(40);
    strokeText("Music: ", width * 0.4, height * 0.4);

    // The button for Music
    noFill();
    rectMode(RADIUS);
    rect(width * 0.58, height *0.39, check_size, check_size);

    // The X sign for Music
    if (toggle_music == true )
    {
      strokeWeight(5);
      stroke(0, 100, 0);
      line(width * 0.581 - check_size / 2, height * 0.39 -check_size / 2, width * 0.581 +check_size / 2, height * 0.39 +check_size / 2);
      line(width * 0.581 -check_size / 2, height * 0.39 +check_size / 2, width * 0.581 +check_size / 2, height * 0.39 -check_size / 2);
    }

    // The text for Cheats
    textFont(Text_font);
    textSize(40);
    strokeText("Cheats: ", width * 0.4, height * 0.5);

    // The button for Cheats
    noFill();
    strokeWeight(2);
    stroke(25, 45, 120);
    rectMode(RADIUS);
    rect(width * 0.58, height *0.49, check_size, check_size);

    // The X sign for Cheats
    if ( cheats == true )
    {
      strokeWeight(5);
      stroke(0, 100, 0);
      line(width * 0.581 - check_size / 2, height * 0.49 -check_size / 2, width * 0.581 +check_size / 2, height * 0.49 +check_size / 2);
      line(width * 0.581 -check_size / 2, height * 0.49 +check_size / 2, width * 0.581 +check_size / 2, height * 0.49 -check_size / 2);
    }


    button("Back", 0.85, 0.95);
  } // end s_menu()
} // Settings