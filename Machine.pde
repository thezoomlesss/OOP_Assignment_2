class Mech
{
  int array_index, move_cond, exists_move_cond, rand_i, new_rand_i, m_no_box=0, holding_box=0, first_run=1;
  int time;
  color mech_colour;
  float m_x_pos, m_y_pos, theta=0;
  float mech_size=60, wheel_size=20;
  ArrayList<Box> boxs=new ArrayList<Box>();
  Box box_obj=new Box();
  Mech()
  {
    this.mech_colour= color(random(0,255),random(0,255),random(0,255));
  }
  
  void spawn_box()
  {
   if(holding_box == 0)
    {
      box_obj=new Box();
      boxs.add(box_obj);
      boxs.get(m_no_box).held=1;
      boxs.get(m_no_box).x_pos= m_x_pos-10;
      boxs.get(m_no_box).y_pos= m_y_pos+45;
      m_no_box++;
      holding_box=1;
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
    rand_i=(int)random(1,background.no_boxes);
    array_index=rand_i;
    m_x_pos=background.width_margin + (rand_i*box.box_size);
    m_y_pos=background.track_height - 1;  // -1 so it goes a little over the track
    move_cond=0;
    exists_move_cond=0;
    
    mechs.add(mech);
    
  }
  void move_m()
  {
    if(move_cond==1) // If the mech should move
    {
        if( m_x_pos < background.width_margin+ 10 +( new_rand_i*box.box_size) )
        {
          m_x_pos +=game_speed;
          theta -=0.07f;
          
          if(m_x_pos > background.width_margin+ 10 +( new_rand_i*box.box_size)) 
          {
            
            m_x_pos =background.width_margin + game_speed +( new_rand_i*box.box_size);
            move_cond=0;
            /*
                Sending the position in the array of where the boxs are being spawned
            */
            boxs.get(m_no_box-1).x=(int) m_x_pos/box.box_size - 1;
            boxs.get(m_no_box-1).y= 0; 
            holding_box=0;
            time = millis();
          }
        }
        else
        {
          m_x_pos -=game_speed;
          theta +=0.07f;
          
          if(m_x_pos < background.width_margin+ 10 +(new_rand_i*box.box_size)) 
          {
            m_x_pos =background.width_margin+ game_speed +(new_rand_i*box.box_size);
            move_cond=0;
            /*
                Sending the position in the array of where the boxs are being spawned
            */
            boxs.get(m_no_box-1).x=(int) m_x_pos/box.box_size - 1;
            boxs.get(m_no_box-1).y= 0; 
            holding_box=0;
            time = millis();
          }
      } // end else
    } // end outer if
    else // else not having a command to move
    {
      // if it is the first run then we instantly  spawn a box
      if(first_run==1)  
      {
        first_run=0;
        spawn_box();
        holding_box=1;
        new_rand_i=(int)random(1,background.no_boxes+1);
        move_cond=1;
      } 
      else // if it is not the first run then we have to wait before spawning a box
      {
        if(millis() > time + 2000)
        {
          spawn_box();
          holding_box=1;
          new_rand_i=(int)random(1,background.no_boxes+1);
          move_cond=1;
        }
      } // end else not the first run
      
    }
    
  } // end move_m
  
  
  void move_b()
  {
    // Moving all the boxs that are in the arraylist boxs
    for(int index2=0; index2 < boxs.size(); index2++)
    {
      boxs.get(index2).move_b();
    }
  } // end move_b()
  
  /* 
      For loop that goes through the ArrayList and displays all the boxs
  */
  
  void disp_boxs()
  {
    for(int index2=0; index2 < boxs.size(); index2++)
    {
      /*
      if((deleted==1) && (mech.boxs.get(index2).y== background.vert_no_boxs-1))
      {
      stroke(0,255,0);
      println("Green");
      }
      else
      {
      stroke(255,0,0);
      }
      */
      
      boxs.get(index2).disp();
    }
  }
  
  
  void draw_m()
  {
    //spawn_box();
    // Body of the mech
    stroke(mech_colour);
    strokeWeight(1);
    fill(mech_colour);
    beginShape();
    vertex(m_x_pos,m_y_pos);
    vertex(m_x_pos+mech_size, m_y_pos);
    vertex(m_x_pos+mech_size, m_y_pos+8);
    vertex(m_x_pos, m_y_pos+8);
    endShape(CLOSE);
     /* 
      Arms of the mech
      We start from m_x_pos + half of the mech size so we get to the exact middle of the mech
    */
    noFill();
    stroke(mech_colour);
    beginShape();
    vertex(m_x_pos + (mech_size*0.5f), m_y_pos+8);   // Point that connects arms to box
    vertex(m_x_pos + (mech_size*0.5f), m_y_pos+20);  // lower point that connects arms
    vertex(m_x_pos - (box.box_size *0.5), m_y_pos+30); // left arm top
    
    if(holding_box==1)
    {
      vertex(m_x_pos - (box.box_size *0.5) , m_y_pos+50); // left arm lower
      if(mech.new_rand_i>mech.rand_i) 
      {  
        vertex(m_x_pos-10 + game_speed, m_y_pos+60);  // left connection
        endShape();
        beginShape();
        vertex(m_x_pos-10 + box.box_size + game_speed , m_y_pos+60); // right connection
      
      }
      else
      {
        vertex(m_x_pos-10 - game_speed, m_y_pos+60); // left connection
        endShape();
        beginShape();
        vertex(m_x_pos-10 +  box.box_size - game_speed , m_y_pos+60); // right connection
      }
      vertex(m_x_pos + (mech_size) + (box.box_size *0.5), m_y_pos+50); // right arm lower
    }
    else  // Not holding box
    {
      vertex(m_x_pos - (box.box_size *0.5) -5, m_y_pos+50); // left arm lower
      vertex(m_x_pos - 25 + game_speed, m_y_pos+60); // left arm connection to box 
      endShape();
      
      beginShape();
      vertex(m_x_pos + (box.box_size)  +10 , m_y_pos+60); // right arm connection to box
      vertex(m_x_pos + (mech_size) + 10 + (box.box_size *0.5), m_y_pos+50); // right arm lower
    }
    
    
    vertex(m_x_pos + (mech_size) + (box.box_size *0.5), m_y_pos+30); // right arm top
    vertex(m_x_pos + (mech_size*0.5f), m_y_pos+20);  // right arm connectio to origin
    endShape();
   
    
    /* Wheels of the mech
       m_y_pos + 4 so the wheel is exactly in the middle of the bar of the mech
       
       Change this to PI and make them move
    */
    fill(0,80,20);
    stroke(0,255,0);
    
    // The wheels
    ellipse(m_x_pos, m_y_pos+4, wheel_size,wheel_size);
    ellipse(m_x_pos + mech_size, m_y_pos+4, wheel_size, wheel_size);
   
    /*
        The spikes
        We draw each spike from the middle of the wheel to the edge which is calculated by sin(theta + index * PI/2) and cos(theta + index * PI/2)
        Theta gets incremented or decremented by 0.07f everytime the mech moves
    */
    
    for(int wheel_index=1; wheel_index<5; wheel_index++)
    {
      line(m_x_pos , m_y_pos + 4, m_x_pos + sin(theta + (wheel_index*PI/2)) *10, m_y_pos + 4 + cos(theta + (wheel_index*PI/2))*10);
      line(m_x_pos +mech_size, m_y_pos + 4, m_x_pos + mech_size + sin(theta + (wheel_index*PI/2)) *10, m_y_pos + 4 + cos(theta + (wheel_index*PI/2))*10);
    }
    
  }
}