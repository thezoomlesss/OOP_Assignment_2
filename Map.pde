class Map
{
  int width_margin=30, height_margin=20;
  float no_boxes, no_vert_lines;  
  Map()
  {
    
  
  }
  void grid()
  { 
    // grid lines
    no_boxes= ((float)width- width_margin*2)/box.box_size;
    no_vert_lines= (height-height_margin*2)/20;
    
    // this for loop draws the grey background lines and the little white lines that can be found on the floor
    for(int i=2; i<no_boxes-1; i++)
    {
      // little white lines 
      strokeWeight(1);
      stroke(55);
      line(width_margin+(i*box.box_size), height-height_margin*2, width_margin+(i*box.box_size), height-height_margin*2 +5);
      // vertical grey lines
      stroke(20);
      for(int j=4; j<no_vert_lines; j++)
      {
        line(width_margin+(i*box.box_size), j*20, width_margin+(i*box.box_size), (j*20)+5);
      } // end inner for loop
    } // end outer for loop
    
    
    
    
    /*
        The floor goes from the width margin + 1 box  ***-2 pixels so it looks better*** 
        and goes all the way to width margin + the number of boxes - 1 multipled by the size of one box *** + 2 pixels so it looks better ***
    */
    strokeWeight(2);
    stroke(50,0,140);
    // Left side verticle purple line
    line(width_margin+box.box_size-3, height-height_margin*2-2, width_margin+box.box_size-3, height-height_margin*2 +6);
    // Right side verticle purple line
    line(width_margin+((no_boxes-1)*box.box_size)+3, height-height_margin*2-2, width_margin+((no_boxes-1)*box.box_size)+3, height-height_margin*2 +6);
    // Floor line
    strokeWeight(5);
    line(width_margin+box.box_size-2, height-height_margin*2+9, width_margin+((no_boxes-1)*box.box_size)+2, height-height_margin*2+9);
    // bottom left angled lines
    strokeWeight(3);
    for(int k=1; k<no_boxes; k++)
    {
      line(width_margin+(k*box.box_size), height-height_margin*2+9, width_margin+(k*box.box_size)-10, height-height_margin*2 +25);
    } // end little for
  } // end void grid
}