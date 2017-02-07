class Credits extends Design implements Screens
{
  void display()
  {    
    backgr();

    textAlign(CENTER);
    textFont(Title_font);
    textSize(80);
    strokeText("C r e d i t s", width * 0.5, height * 0.2);

    textFont(Text_font);
    textSize(40);
    strokeText("Music: HOME", width * 0.5, height *0.5);
    strokeText("Code: Mohamad Zabad (Mushy)", width * 0.5, height *0.6);

    button("Back", 0.85, 0.95);
  }
}