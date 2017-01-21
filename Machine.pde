class Mech
{
  int array_index;
  float m_x_pos, m_y_pos;
  float mech_size=40, wheel_size=20;
  
  Mech()
  {
    
  }
  
  void spawn_box()
  {
    box.held=1;
    boxes.add(box);
    array_rows[1][1]=1;
  }
  void spawn_m()
  {
    this.array_index=0;
    // add values for m_x_pos and m_y_pos
    this.m_x_pos=random(background.width_margin, width- background.width_margin);
    println("width=",width);
    this.m_y_pos=background.track_height - 1;  // -1 so it goes a little over the track

  }
  void change_pos()
  {
    
  }
  
  void draw_m()
  {
    
    // Body of the mech
    stroke(200,0,0);
    strokeWeight(1);
    fill(200,0,0);
    beginShape();
    vertex(this.m_x_pos,m_y_pos);
    vertex(this.m_x_pos+mech_size, m_y_pos);
    vertex(this.m_x_pos+mech_size, m_y_pos+8);
    vertex(this.m_x_pos, m_y_pos+8);
    endShape(CLOSE);
    fill(0,80,20);
    stroke(0,255,0);
    /* Wheels of the mech
       m_y_pos + 4 so the wheel is exactly in the middle of the bar of the mech
       
       Change this to PI and make them move
    */
    ellipse(this.m_x_pos, this.m_y_pos+4, wheel_size,wheel_size);
    ellipse(this.m_x_pos + mech_size, this.m_y_pos+4, wheel_size, wheel_size);
    line(this.m_x_pos, this.m_y_pos+4, this.m_x_pos+mech_size, this.m_y_pos+4); // Line that connects the wheels
    line(this.m_x_pos, this.m_y_pos-6, this.m_x_pos, this.m_y_pos+14);
    line(this.m_x_pos+mech_size, this.m_y_pos-6, this.m_x_pos+mech_size, this.m_y_pos+14);
  }
}

class Box
{
  // x position in the array and held=1 means that it's held by the machine
  int x, held; 
  int x_pos, y_pos, box_size=60;
  
  Box()
  { // The 0 values will be changed with the position of the Mech once it will be done
    this.x_pos=background.width_margin+(box_size) + (box_size*0);
    this.y_pos=background.height_margin*3;

  }
  void disp()
  {
    // Remmber to work on the colors here
    strokeWeight(1);
    stroke(255,0,0);
    noFill();
    beginShape();
    vertex(this.x_pos, this.y_pos);
    vertex(this.x_pos + box_size, this.y_pos);
    vertex(this.x_pos+box_size, this.y_pos + box_size);
    vertex(this.x_pos, this.y_pos + box_size);
    endShape(CLOSE);
  } 
  void update()
  {
    // Every second we will check if any box has to be dropped lower
    if(frameCount % 60 == 0)
    {
      
    }
  }
}// end Machine class