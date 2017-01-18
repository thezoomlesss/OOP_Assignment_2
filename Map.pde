class Map
{
  int box_size=30;
  int width_margin=20, height_margin=10;
  
  Map()
  {
    
  }
  void grid()
  {
    /*strokeWeight(2);
    stroke(50,0,140);
    */
    int no_boxes= (width- width_margin*2)/box_size;
    int no_vert_lines= (height-height_margin*2)/20;
    println(no_boxes);
    
    for(int i=1; i<no_boxes; i++)
    {
    
      strokeWeight(1);
      stroke(255);
      line(width_margin+(i*box_size), height-height_margin*2, width_margin+(i*box_size), height-height_margin*2 +5);
      stroke(15);
      for(int j=1; j<no_vert_lines; j++)
      {
        line(width_margin+(i*box_size), j*20, width_margin+(i*box_size), (j*20)+5);
      }
    } // end for
  }
}