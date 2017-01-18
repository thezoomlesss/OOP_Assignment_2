class Map
{
  int box_size=30;
  int width_margin=30, height_margin=20;
    
  Map()
  {
    
  
  }
  void grid()
  { 
    // grid lines
    float no_boxes= ((float)width- width_margin*2)/box_size;
    int no_vert_lines= (height-height_margin*2)/20;
    for(int i=1; i<no_boxes; i++)
    {
      // little white lines 
      strokeWeight(1);
      stroke(255);
      line(width_margin+(i*box_size), height-height_margin*2, width_margin+(i*box_size), height-height_margin*2 +5);
      
      // vertical grey lines
      stroke(15);
      for(int j=1; j<no_vert_lines; j++)
      {
        line(width_margin+(i*box_size), j*20, width_margin+(i*box_size), (j*20)+5);
      } // end inner for loop
    } // end outer for loop
    
    // Floor line
    strokeWeight(2);
    stroke(50,0,140);
    line(width_margin+box_size, height-height_margin*2-2, width_margin+box_size, height-height_margin*2 +5);
    line(width_margin+((int)no_boxes*box_size), height-height_margin*2-2, width_margin+((int)no_boxes*box_size), height-height_margin*2 +5);
    strokeWeight(5);
    line(width_margin+box_size, height-height_margin*2+9, width_margin+((int)no_boxes*box_size), height-height_margin*2+9);
  }
}