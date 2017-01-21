class Mech
{
  
}

class Box
{
  // x position in the array and held=1 means that it's held by the machine
  int x, held=1; 
  int x_pos, y_pos, box_size=30;
  
  Box()
  { // The 0 values will be changed with the position of the Mech once it will be done
    this.x_pos=(background.width_margin*2) + (box_size*0);
    this.y_pos=background.height_margin*3 + (box_size*0);
    array_rows[1][1]=1;    // [1][1] to be changed to the position of the mech
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