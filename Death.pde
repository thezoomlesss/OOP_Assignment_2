class Death extends Design implements Screens
{
  void display()
  {
    backgr();
    // The title
    textAlign(CENTER);
    textFont(Title_font);
    textSize(120);
    strokeText("Y O U  A R E  D E A D", width * 0.5, height * 0.5);

    button("Back", 0.85, 0.95);

    // The score
    strokeText("Your score is: "+score, width *0.5, height * 0.76);
  } // end display
} // end Death