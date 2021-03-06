class Map
{
  int width_margin=30, height_margin=20;
  int track_height=height_margin-5;
  int no_boxes, vert_no_boxes, no_vert_lines, score_box=100; 


  void grid_initial()
  {
    background(0, 0, 17);
    no_boxes=(width- width_margin*2 - box.box_size * 2)/box.box_size;
    no_vert_lines= (height-height_margin*2)/20;             // It's devided by 20 cause that's the distance we want between our vert lines
    vert_no_boxes= (height-height_margin*2)/box.box_size;  // variable used to define the size of the array
  } // end grid_initial()

  void score()
  {
    // Here we make the box for the score and write the current score
    textAlign(CENTER);
    textFont(Text_font);
    textSize(22);
    strokeText(String.valueOf(score), character.c_x_pos + character.c_size/2, character.c_y_pos - character.c_size/4);
  }

  void grid() // grid lines
  { 
    background(0, 0, 17);
    // this for loop draws the grey background lines and the little white lines that can be found on the floor
    for (int i=2; i<no_boxes+1; i++)
    {
      // little white lines 
      strokeWeight(1);
      stroke(55);
      line(width_margin+(i*box.box_size), height-height_margin*2, width_margin+(i*box.box_size), height-height_margin*2 +5);
      // vertical grey lines
      stroke(20);
      for (int j=4; j<no_vert_lines; j++)
      {
        line(width_margin+(i*(box.box_size) ), j*20, width_margin+(i*box.box_size ), (j*20)+5);
      } // end inner for loop
    } // end outer for loop


    // Mech track
    fill(0);
    strokeWeight(2);
    stroke(160, 82, 45);
    beginShape();
    vertex(width_margin-10, track_height);
    vertex(width_margin-15, track_height+6);
    vertex(width-(width_margin-15), track_height+6);
    vertex(width-(width_margin-10), track_height);
    endShape(CLOSE);

    /*
        The floor goes from the width margin + 1 box  ***-2 pixels so it looks better*** 
     and goes all the way to width margin + the number of boxes - 1 multipled by the size of one box *** + 2 pixels so it looks better ***
     */
    strokeWeight(2);
    stroke(50, 0, 140);
    // Left side verticle purple line
    line(width_margin+box.box_size-3, height-height_margin*2-2, width_margin+box.box_size-3, height-height_margin*2 +6);
    // Right side verticle purple line
    line(width_margin+((no_boxes+1)*box.box_size), height-height_margin*2-2, width_margin+((no_boxes+1)*box.box_size), height-height_margin*2 +6);
    // Floor line
    strokeWeight(5);
    line(width_margin+box.box_size, height-height_margin*2+9, width_margin + ( (no_boxes+1)* box.box_size ), height-height_margin*2+9);
    // bottom left angled lines  
    strokeWeight(3);
    for (int k=1; k<no_boxes+1; k++)
    {
      line(width_margin+(k*box.box_size), height-height_margin*2+9, width_margin+(k*box.box_size)-10, height-height_margin*2 +25);
    } // end little for
  } // end void grid
}