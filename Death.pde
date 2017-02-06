class Death
{
  void display()
  {
    menu.display_border();
    
    // The title
    textAlign(CENTER);
    textFont(Title_font);
    textSize(120);
    strokeText("Y O U  A R E  D E A D", width * 0.5, height * 0.5);
    
    //The back button
    if(mouseX> width * 0.45 && mouseX < width * 0.55 && mouseY > height * 0.85 && mouseY< height * 0.95)
    {
      fill(0,55,205); // Hovered color
      stroke(15,25,50);
      strokeWeight(6);
    }
    else
    {
      fill(10,8,25); // Not hovered
      strokeWeight(4);
      stroke(25,45,120); 
    }
    beginShape();
    vertex(width * 0.45, height * 0.85);
    vertex(width * 0.45, height * 0.95);
    vertex(width * 0.55, height * 0.95);
    vertex(width * 0.55, height * 0.85);
    endShape(CLOSE);
    
    textFont(Text_font);
    textSize(40);
    textAlign(CENTER);
    strokeText("Back", width * 0.5, height * 0.91);
    
    // The score
    strokeText("Your score is: "+score, width *0.5, height * 0.76);
    
  } // end display
} // end Death