class Machine
{
  int x; // x position in the array
  int x_pos, y_pos, box_size=30;
  PShape cart;
  
  Machine(int a, int b)
  {
    this.x_pos=a;
    this.y_pos=b;
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
}// end Machine class