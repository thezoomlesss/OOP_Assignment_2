class Death extends Design implements Screens
{
  void display()
  {
    backgr();
    textAlign(CENTER);
    title("Y O U  A R E  D E A D", 0.5, 0.5, - 40);
    button("Back", 0.85, 0.95);
    
    // The score
    strokeText("Your score is: "+score, width *0.5, height * 0.76);
  } // end display
} // end Death