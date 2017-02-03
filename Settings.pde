class Settings
{
  boolean toggle_music=true, playing=true;
  int check_size= 30;
  
  void s_menu()
  {
    menu.display_border();
    textAlign(CENTER);
    
    // The title
    
    textFont(Title_font);
    textSize(80);
    strokeText("Settings", width * 0.5, height * 0.1);
    
    // The text
    textFont(Text_font);
    textSize(40);
    strokeText("Music: ", width * 0.4, height * 0.4);
    
    noFill();
    rectMode(RADIUS);
    rect(width * 0.58, height *0.39, check_size,check_size);
    
    if(toggle_music == true )
    {
      strokeWeight(5);
      stroke(0,100,0);
      line(width * 0.581 - check_size / 2, height * 0.39 -check_size / 2, width * 0.581 +check_size / 2, height * 0.39 +check_size / 2);
      line(width * 0.581 -check_size / 2, height * 0.39 +check_size / 2, width * 0.581 +check_size / 2, height * 0.39 -check_size / 2);  
    }
    
    // The back button
    if(mouseX> width * 0.45 && mouseX < width * 0.55 && mouseY > height * 0.85 && mouseY< height * 0.95)
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
    vertex(width * 0.45, height * 0.85);
    vertex(width * 0.45, height * 0.95);
    vertex(width * 0.55, height * 0.95);
    vertex(width * 0.55, height * 0.85);
    endShape(CLOSE);
    
    textAlign(CENTER);
    strokeText("Back", width * 0.5, height * 0.91);
    
  } // end s_menu()
} // Settings