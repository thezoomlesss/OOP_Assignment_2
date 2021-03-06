abstract class Design
{
  void title(String string, float x, float y, int size)   // The function used in many classes to display the titles
  {
    // The title
    textFont(Title_font);
    textSize(title_size - size );
    strokeText(string, width * x, height * y);
  }
  
  void button(String a, float low, float high)        // The function used in many classes to display the buttons
  {
    // Colouring the button
    if (mouseX> width * 0.45 && mouseX < width * 0.55 && mouseY > height * low && mouseY< height * high)
    {
      fill(0, 55, 205);    // Hovered color
      stroke(15, 25, 50);
      strokeWeight(6);
    } else
    {
      fill(10, 8, 25);     // Not hovered
      strokeWeight(4);
      stroke(25, 45, 120);
    }
    // The button box
    beginShape();
    vertex(width * 0.45, height * low);
    vertex(width * 0.45, height * high);
    vertex(width * 0.55, height * high);
    vertex(width * 0.55, height * low);
    endShape(CLOSE);
    // The text for the button
    textFont(Text_font);
    textSize(text_size);
    textAlign(CENTER);
    strokeText( a, width * 0.5, height * ((high+low)/2 +0.01));
  }

  void backgr()            // The function used in many classes to display the background
  {
    int x_coord =20, y_coord=20;
    int x_coord_copy= x_coord+5, y_coord_copy= y_coord +6;

    /*
        This is the border for the menu screen
     */
    background(0, 0, 17);
    stroke(25, 45, 120);    
    strokeWeight(2);
    noFill();

    line( 2 * x_coord, y_coord, width -   x_coord_copy, y_coord); // top outer line
    line(x_coord, 2 * y_coord, x_coord, height - 2 * y_coord_copy); // left outer  
    line(width -  2*x_coord, height-y_coord, x_coord_copy, height-y_coord);  // bottom outer
    line(width - x_coord, height - 2 * y_coord, width- x_coord, y_coord_copy); // right outer 

    bezier(width-x_coord, height - 2 * y_coord, width-x_coord, height-y_coord, width-x_coord, height-y_coord, width-2 * x_coord, height-y_coord); // bottom right outer bezier
    bezier(x_coord, 2 * y_coord, x_coord, y_coord, x_coord, y_coord, 2 * x_coord, y_coord); // top left outer bezier
    bezier(width -  2*x_coord, y_coord, width-x_coord, y_coord, width-x_coord, y_coord, width - x_coord, 2*y_coord); // top right outer bezier
    bezier(x_coord_copy, height-y_coord, x_coord, height-y_coord, x_coord, height-y_coord, x_coord, height-2*y_coord_copy); // bottom left outer bezier

    fill(6, 7, 15);
    beginShape();
    vertex(x_coord_copy, y_coord_copy);
    vertex(width-x_coord_copy, y_coord_copy);
    vertex(width-x_coord_copy, height-y_coord_copy);
    vertex(x_coord_copy, height-y_coord_copy);
    endShape(CLOSE);
  } // end backgr
} // end class