class Menu
{
  int x_coord =20, y_coord=20;
  int x_coord_copy= x_coord+5, y_coord_copy= y_coord +6;
  int button_width= 100, button_height= (int)(button_width* 0.5);
  float pos= 0.4f;
  
  void display_border()
  {
    /*
        This is the border for the menu screen
    */
    
    stroke(25,45,120);    
    strokeWeight(2);
    noFill();
    
    line( 2 * x_coord, y_coord, width -   x_coord_copy , y_coord); // top outer line
    line(x_coord, 2 * y_coord, x_coord, height - 2 * y_coord_copy); // left outer  
    line(width -  2*x_coord, height-y_coord,  x_coord_copy, height-y_coord);  // bottom outer
    line(width - x_coord, height - 2 * y_coord, width- x_coord,  y_coord_copy); // right outer 
    
    bezier(width-x_coord,height - 2 * y_coord, width-x_coord, height-y_coord, width-x_coord, height-y_coord,width-2 * x_coord, height-y_coord); // bottom right outer bezier
    bezier(x_coord,2 * y_coord, x_coord, y_coord, x_coord, y_coord ,2 * x_coord, y_coord); // top left outer bezier
    bezier(width -  2*x_coord,  y_coord, width-x_coord,  y_coord, width-x_coord,  y_coord, width - x_coord,  2*y_coord); // top right outer bezier
    bezier(x_coord_copy,  height-y_coord, x_coord,  height-y_coord, x_coord,  height-y_coord, x_coord,  height-2*y_coord_copy); // bottom left outer bezier
    
    
    fill(6,7,15);
    beginShape();
    vertex(x_coord_copy, y_coord_copy);
    vertex(width-x_coord_copy, y_coord_copy);
    vertex(width-x_coord_copy, height-y_coord_copy);
    vertex(x_coord_copy, height-y_coord_copy);
    endShape(CLOSE);
    
  }
  
  void title()
  {
    textSize(100);
    fill(200,0,0);
    text("Stack Challenge", width * 0.425f - button_width, height * 0.2);
  }
  
  void buttons()
  {
    
    
    stroke(25,45,120);    
    strokeWeight(4);
    
    
    
    
    for(int index=0; index<12; index+=4)
    {
      // Here we check if the buttons are being hovered
      if(mouseX> width * 0.5f - button_width && mouseX <width * 0.5f + button_width)
      {
        if(  mouseY> height * pos + index  * button_height - button_height && mouseY< height * pos + index  * button_height + button_height)
        {
           fill(0,55,85);
           stroke(15,25,50); 
        }
        else
        {
          fill(10,8,25);
          stroke(25,45,120); 
        } 
     }
     else
     {
       fill(10,8,25);
       stroke(25,45,120); 
     }
      
      
      beginShape();
      vertex( width * 0.5f - button_width, height * pos + index  * button_height - button_height);
      vertex( width * 0.5f - button_width, height * pos + index  * button_height + button_height);
      vertex( width * 0.5f + button_width, height * pos + index  * button_height + button_height);
      vertex( width * 0.5f + button_width, height * pos + index  * button_height - button_height);
      endShape(CLOSE);
    }
    
    
    textSize(30);
    strokeText("New Game", width * 0.5f - button_width + 50, height * pos + 0.2 * button_height);
    strokeText("Leaderboards", width * 0.5f - button_width + 35, height * pos + 4.2 * button_height);
    strokeText("Settings", width * 0.5f - button_width + 60, height * pos + 8.2 * button_height);
    
  }
} // end class Menu