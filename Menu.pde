class Menu extends Design
{
  int x_coord =20, y_coord=20;
  int x_coord_copy= x_coord+5, y_coord_copy= y_coord +6;
  int button_width= 100, button_height= (int)(button_width* 0.5);
  float pos= 0.4f;
  
  void display_border()
  {
    backgr();  // This shouldn't be here
  }
  
  void title()
  {
    textFont(Title_font);
    textAlign(CENTER);
    textSize(100);
    fill(200,0,0);
    text("Stack Challenge", width * 0.5, height * 0.2);
  }
  
  void buttons()
  {
    int menu_box_margin=40;
    textFont(Text_font);
    stroke(25,45,120);    
    strokeWeight(4);
    fill(10,8,15);
    
    beginShape();
    vertex(width * 0.5f - button_width - menu_box_margin, height * pos  - button_height - menu_box_margin);
    vertex(width * 0.5f - button_width - menu_box_margin, height * pos + 6 * button_height + button_height + menu_box_margin);
    vertex(width * 0.5f + button_width + menu_box_margin, height * pos + 6 * button_height + button_height + menu_box_margin);
    vertex(width * 0.5f + button_width + menu_box_margin, height * pos  - button_height - menu_box_margin);
    endShape(CLOSE);
    
    for(int index=0; index<9; index+=3)
    {
      // Here we check if the buttons are being hovered
      if(mouseX> width * 0.5f - button_width && mouseX <width * 0.5f + button_width)
      {
        if(  mouseY> height * pos + index  * button_height - button_height && mouseY< height * pos + index  * button_height + button_height)
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
     }
     else
     {
       fill(10,8,25);    
       strokeWeight(4);
       stroke(25,45,120); 
     }
      
      
      beginShape();
      vertex( width * 0.5f - button_width, height * pos + index  * button_height - button_height);
      vertex( width * 0.5f - button_width, height * pos + index  * button_height + button_height);
      vertex( width * 0.5f + button_width, height * pos + index  * button_height + button_height);
      vertex( width * 0.5f + button_width, height * pos + index  * button_height - button_height);
      endShape(CLOSE);
    }
    
    
    textSize(23);
    strokeText("New Game", width * 0.5f, height * pos + 0.2 * button_height);
    strokeText("Leaderboards", width * 0.5f , height * pos + 3.2 * button_height);
    strokeText("Settings", width * 0.5f , height * pos + 6.2 * button_height);
    textAlign(LEFT);
  }
} // end class Menu