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
    no_boxes= ((float)width- width_margin*2)/mech.box_size;
    no_vert_lines= (height-height_margin*2)/20;
    for(int i=2; i<no_boxes-1; i++)
    {
      // little white lines 
      strokeWeight(1);
      stroke(55);
      line(width_margin+(i*mech.box_size), height-height_margin*2, width_margin+(i*mech.box_size), height-height_margin*2 +5);
      
      // vertical grey lines
      stroke(18);
      for(int j=4; j<no_vert_lines; j++)
      {
        line(width_margin+(i*mech.box_size), j*20, width_margin+(i*mech.box_size), (j*20)+5);
      } // end inner for loop
    } // end outer for loop
    
    strokeWeight(2);
    stroke(50,0,140);
    
    // Left side verticle purple line
    line(width_margin+mech.box_size-3, height-height_margin*2-2, width_margin+mech.box_size-3, height-height_margin*2 +5);
    // Right side verticle purple line
    line(width_margin+((int)no_boxes*mech.box_size)+3, height-height_margin*2-2, width_margin+((int)no_boxes*mech.box_size)+3, height-height_margin*2 +5);
    
    // Floor line
    strokeWeight(5);
    line(width_margin+mech.box_size-2, height-height_margin*2+9, width_margin+((int)no_boxes*mech.box_size)+2, height-height_margin*2+9);
    
    // bottom left angled lines
    strokeWeight(3);
    for(int k=1; k<no_boxes; k++)
    {
      line(width_margin+(k*mech.box_size), height-height_margin*2+9, width_margin+(k*mech.box_size)-10, height-height_margin*2 +25);
    } // end little for
  }
}