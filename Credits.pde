class Credits extends Design implements Screens
{
  void display()
  {    
    backgr();
    textAlign(CENTER);
    title("C r e d i t s",0.5, 0.2, 0);
    textFont(Text_font);
    textSize(text_size);
    strokeText("All the Code Written By :  Mohamad Zabad (Mushy)", width * 0.5, height *0.5);
    strokeText("Music: HOME", width * 0.5, height *0.6);
    button("Back", 0.85, 0.95);
  } // end display
} // end class Credits