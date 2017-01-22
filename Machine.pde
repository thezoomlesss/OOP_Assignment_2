class Mech
{
  int array_index, move_cond, exists_move_cond, rand_i, new_rand_i;
  float m_x_pos, m_y_pos;
  float mech_size=40, wheel_size=20;
  
  Mech()
  {
    
  }
  
  void spawn_box()
  {
    box.held=1;
    boxes.add(box);
    box.x_pos=(int) this.m_x_pos-10;
    box.y_pos=(int) this.m_y_pos+45;
    array_rows[1][1]=1;
  }
  void spawn_m()
  {
    /*
        Here we are spawning one machine
        it will randomize an index where it wants to spawn
        it will mark that index as occupied 
        it will display at the location of width_margin + the index multiplied by the size of a single box + *** 10 pixels so the box will be alligned ***
    */
    this.rand_i=(int)random(1,background.no_boxes);
    this.array_index=rand_i;
    this.m_x_pos=background.width_margin+ 10 +(rand_i*box.box_size);
    this.m_y_pos=background.track_height - 1;  // -1 so it goes a little over the track
    this.move_cond=1;
    this.exists_move_cond=0;
  }
  void move_m()
  {
    if(this.move_cond==1)
    {
      if(this.exists_move_cond==0)
      {
        this.new_rand_i=(int)random(1,background.no_boxes);
        this.exists_move_cond=1;
      }
      
      if( this.m_x_pos < background.width_margin+ 10 +(new_rand_i*box.box_size) )
      {
        this.m_x_pos +=1;
        if(this.m_x_pos == background.width_margin+ 10 +(new_rand_i*box.box_size)) this.exists_move_cond=0;
      }
      else
      {
        this.m_x_pos -=1;
        if(this.m_x_pos == background.width_margin+ 10 +(new_rand_i*box.box_size)) this.exists_move_cond=0;

        
      } // end else
      
    } // end outer if
  } // end move_m
  
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
     /* 
      Arms of the mech
      We start from m_x_pos + half of the mech size so we get to the exact middle of the mech
    */
    noFill();
    stroke(255,0,0);
    beginShape();
    vertex(this.m_x_pos + (mech_size*0.5f), this.m_y_pos+8);   // Point that connects arms to box
    vertex(this.m_x_pos + (mech_size*0.5f), this.m_y_pos+20);  // lower point that connects arms
    vertex(this.m_x_pos - (box.box_size *0.5), this.m_y_pos+30); // left arm top
    vertex(this.m_x_pos - (box.box_size *0.5), this.m_y_pos+50); // left arm lower
    vertex(this.m_x_pos + 4- (box.box_size *0.25), this.m_y_pos+60); // left arm connection to box
    endShape();
    beginShape();
    vertex(this.m_x_pos + (mech_size) - 4 + (box.box_size *0.25), this.m_y_pos+60); // right arm connection to box
    vertex(this.m_x_pos + (mech_size) + (box.box_size *0.5), this.m_y_pos+50); // right arm lower
    vertex(this.m_x_pos + (mech_size) + (box.box_size *0.5), this.m_y_pos+30); // right arm top
    vertex(this.m_x_pos + (mech_size*0.5f), this.m_y_pos+20);  // lower point that connects arms 
    endShape();
   
    
    /* Wheels of the mech
       m_y_pos + 4 so the wheel is exactly in the middle of the bar of the mech
       
       Change this to PI and make them move
    */
    fill(0,80,20);
    stroke(0,255,0);
    
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
    //this.x_pos=background.width_margin+(box_size) + (box_size*0);
    //this.y_pos=background.height_margin*3;

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
  void move_b()
  {
    
  }
}// end Machine class