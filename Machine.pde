class Mech
{
  int array_index, move_cond, exists_move_cond, rand_i, new_rand_i, m_no_box=0, holding_box=0, first_run=1;
  int time;
  float m_x_pos, m_y_pos, theta=0;
  float mech_size=60, wheel_size=20;
  ArrayList<Box> boxs=new ArrayList<Box>();
  Box box_obj=new Box();
  Mech()
  {
    
  }
  
  void spawn_box()
  {
   if(this.holding_box == 0)
    {
      box_obj=new Box();
      boxs.add(box_obj);
      boxs.get(m_no_box).held=1;
      boxs.get(m_no_box).x_pos= this.m_x_pos-10;
      boxs.get(m_no_box).y_pos= this.m_y_pos+45;
      this.m_no_box++;
      this.holding_box=1;
    }
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
    this.array_index=this.rand_i;
    this.m_x_pos=background.width_margin + (this.rand_i*box.box_size);
    this.m_y_pos=background.track_height - 1;  // -1 so it goes a little over the track
    this.move_cond=0;
    this.exists_move_cond=0;
  }
  void move_m()
  {
    if(this.move_cond==1)
    {
        if( this.m_x_pos < background.width_margin+ 10 +(this.new_rand_i*box.box_size) )
        {
          this.m_x_pos +=game_speed;
          this.theta -=0.07f;
          
          if(this.m_x_pos > background.width_margin+ 10 +(this.new_rand_i*box.box_size)) 
          {
            
            this.m_x_pos =background.width_margin + game_speed +(this.new_rand_i*box.box_size);
            this.move_cond=0;
            /*
                Sending the position in the array of where the boxes are being spawned
            */
            boxs.get(m_no_box-1).x=(int) this.m_x_pos/box.box_size - 1;
            boxs.get(m_no_box-1).y= 0; 
            this.holding_box=0;
            time = millis();
          }
        }
        else
        {
          this.m_x_pos -=game_speed;
          this.theta +=0.07f;
          
          if(this.m_x_pos < background.width_margin+ 10 +(this.new_rand_i*box.box_size)) 
          {
            
            this.m_x_pos =background.width_margin+ game_speed +(this.new_rand_i*box.box_size);
            this.move_cond=0;
            /*
                Sending the position in the array of where the boxes are being spawned
            */
            boxs.get(m_no_box-1).x=(int) this.m_x_pos/box.box_size - 1;
            boxs.get(m_no_box-1).y= 0; 
            this.holding_box=0;
            time = millis();
          }
      } // end else
    } // end outer if
    else
    {
      if(this.first_run==1)
      {
        this.first_run=0;
        spawn_box();
        this.holding_box=1;
        this.new_rand_i=(int)random(1,background.no_boxes+1);
        this.move_cond=1;
      } 
      else
      {
        if(millis() > this.time + 2000)
        {
          spawn_box();
          this.holding_box=1;
          this.new_rand_i=(int)random(1,background.no_boxes+1);
          this.move_cond=1;
        }
      }
      
        
        
      
    }
  } // end move_m
  
  void draw_m()
  {
    //spawn_box();
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
    
    if(this.holding_box==1)
    {
      vertex(this.m_x_pos - (box.box_size *0.5) , this.m_y_pos+50); // left arm lower
      if(mech.new_rand_i>mech.rand_i) 
      {  
        vertex(this.m_x_pos-10 + game_speed, this.m_y_pos+60);  // left connection
        endShape();
        beginShape();
        vertex(this.m_x_pos-10 + box.box_size + game_speed , this.m_y_pos+60); // right connection
      
      }
      else
      {
        vertex(this.m_x_pos-10 - game_speed, this.m_y_pos+60); // left connection
        endShape();
        beginShape();
        vertex(this.m_x_pos-10 +  box.box_size - game_speed , this.m_y_pos+60); // right connection
      }
      vertex(this.m_x_pos + (mech_size) + (box.box_size *0.5), this.m_y_pos+50); // right arm lower
    }
    else  // Not holding box
    {
      vertex(this.m_x_pos - (box.box_size *0.5) -5, this.m_y_pos+50); // left arm lower
      vertex(this.m_x_pos - 25 + game_speed, this.m_y_pos+60); // left arm connection to box 
      endShape();
      
      beginShape();
      vertex(this.m_x_pos + (box.box_size)  +10 , this.m_y_pos+60); // right arm connection to box
      vertex(this.m_x_pos + (mech_size) + 10 + (box.box_size *0.5), this.m_y_pos+50); // right arm lower
    }
    
    
    vertex(this.m_x_pos + (mech_size) + (box.box_size *0.5), this.m_y_pos+30); // right arm top
    vertex(this.m_x_pos + (mech_size*0.5f), this.m_y_pos+20);  // right arm connectio to origin
    endShape();
   
    
    /* Wheels of the mech
       m_y_pos + 4 so the wheel is exactly in the middle of the bar of the mech
       
       Change this to PI and make them move
    */
    fill(0,80,20);
    stroke(0,255,0);
    
    // The wheels
    ellipse(this.m_x_pos, this.m_y_pos+4, wheel_size,wheel_size);
    ellipse(this.m_x_pos + mech_size, this.m_y_pos+4, wheel_size, wheel_size);
   
    /*
        The spikes
        We draw each spike from the middle of the wheel to the edge which is calculated by sin(theta + index * PI/2) and cos(theta + index * PI/2)
        Theta gets incremented or decremented by 0.07f everytime the mech moves
    */
    
    for(int wheel_index=1; wheel_index<5; wheel_index++)
    {
      line(this.m_x_pos , this.m_y_pos + 4, this.m_x_pos + sin(this.theta + (wheel_index*PI/2)) *10, this.m_y_pos + 4 + cos(this.theta + (wheel_index*PI/2))*10);
      line(this.m_x_pos +mech_size, this.m_y_pos + 4, this.m_x_pos + mech_size + sin(this.theta + (wheel_index*PI/2)) *10, this.m_y_pos + 4 + cos(this.theta + (wheel_index*PI/2))*10);
    }
    
  }
}

class Box
{
  // x position in the array and held=1 means that it's held by the machine
  float x_pos, y_pos; 
  int x, y, held, box_size=80;
  Box()
  { 
    
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
    vertex(this.x_pos + box_size, this.y_pos + box_size);
    vertex(this.x_pos, this.y_pos + box_size);
    endShape(CLOSE);
  } 
  
  void move_b()
  {
    if (this.held==1)
    {
      // move horizontally
      if(mech.move_cond==1)
      {
        if( mech.m_x_pos < background.width_margin+ 10 +(mech.new_rand_i*box.box_size) )
        {
          this.x_pos +=game_speed;
        }
        else
        {
          this.x_pos -=game_speed;
          //if( mech.m_x_pos == background.width_margin+ 10 +(mech.new_rand_i*box.box_size) ) this.x_pos++;
          // Why do I have this?
  
        } // end else
      }
      else
      {
        this.x_pos+=game_speed;
        this.held=0;
      }// end else
    }
    else
    {
      /* 
          Here the boxes will move vertically
          I am first putting the value 1 in the array of boxes to mark the current position of the box
          checking if it's not on the last line already and if the next line is free so it can keep falling
          check if it's above the floor and lowering the box
          when it reaches the position of the next box (that we calculated before moving) then it will reset the last position
          increment the y so it goes to the right position into the array and puts the value 1 to mark it as occupied
      */
      array_rows[this.y][this.x]=1;
      if((this.y!=background.vert_no_boxes-1) && array_rows[this.y+1][this.x]!=1)
      {
        if(this.y_pos < height-background.height_margin*2 - box_size + 4) 
        {
          this.y_pos +=game_speed;
          if( this.y_pos > height-background.height_margin*2 - box_size * (background.vert_no_boxes-this.y-1) + 4) 
          {
            array_rows[this.y][this.x]=0;
            this.y++;
          }// end inner if
        } // end middle if
      } // end outer if
    } // end else
  } // end move_b
}// end Machine class