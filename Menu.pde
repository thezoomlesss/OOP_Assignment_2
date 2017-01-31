class Menu
{
  int x_coord =20, y_coord=20;
  int x_coord_copy= x_coord+5, y_coord_copy= y_coord +6;
  int button_width= 100, button_height= (int)(button_width* 0.5);
  
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
    
    
    fill(10,8,15);
    beginShape();
    vertex(x_coord_copy, y_coord_copy);
    vertex(width-x_coord_copy, y_coord_copy);
    vertex(width-x_coord_copy, height-y_coord_copy);
    vertex(x_coord_copy, height-y_coord_copy);
    endShape(CLOSE);
    
  }
  
  void title()
  {
    
  }
  
  void buttons()
  {
    float pos= 0.4f;
    
    stroke(25,45,120);    
    strokeWeight(2);
    fill(10,8,25);
    
    for(int index=0; index<12; index+=4)
    {
      beginShape();
      vertex( width * 0.5f - button_width, height * pos + index  * button_height - button_height);
      vertex( width * 0.5f - button_width, height * pos + index  * button_height + button_height);
      vertex( width * 0.5f + button_width, height * pos + index  * button_height + button_height);
      vertex( width * 0.5f + button_width, height * pos + index  * button_height - button_height);
      endShape(CLOSE);
    }
  }
} // end class Menu