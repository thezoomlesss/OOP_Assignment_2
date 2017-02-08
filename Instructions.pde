class Instructions extends Body implements Screens
{
  color colour= color(random(0, 255), random(0, 255), random(0, 255));
  ; 

  void display()
  {
    backgr();

    title("I n s t r u c t i o n s", 0.5, 0.12, 0);

    textFont(Text_font);
    textSize(text_size);

    // The WASD instruction
    strokeText("W", width * 0.1, height * 0.23);
    strokeText("A", width * 0.07, height * 0.28);
    strokeText("S", width * 0.1, height * 0.295);
    strokeText("D", width * 0.13, height * 0.28);
    strokeText("-", width * 0.17, height * 0.27);
    strokeText("Movement", width * 0.28, height * 0.27);

    // The F instruction
    strokeText("F", width * 0.08, height * 0.53);
    strokeText("-", width * 0.13, height * 0.53);
    strokeText("Toggle  Push/Climb", width * 0.3, height * 0.53);

    // The character modes instruction
    draw_c(false, width * 0.9, height * 0.219, 80, colour);
    draw_c(true, width * 0.9, height * 0.47, 80, colour);

    strokeText("Climb mode -", width * 0.76, height * 0.265);
    strokeText("Push mode -", width * 0.755, height * 0.516);


    button("Start", 0.73, 0.83);
    button("Back", 0.85, 0.95);
  }
}