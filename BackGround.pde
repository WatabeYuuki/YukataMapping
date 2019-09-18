class BackGround
{
  PGraphics canvas;
  int currentColorIndex = 0;
  color[] bgColors;

  BackGround(color[] _bgColors)
  {
    bgColors = _bgColors;
    canvas = createGraphics(600, 600);
    canvas.beginDraw();
    canvas.background(bgColors[currentColorIndex]);
    canvas.endDraw();
  }

  void display()
  {
    background(bgColors[currentColorIndex]);
    canvas.background(bgColors[currentColorIndex]);
    //image(canvas, 0, 0);
  }

  void nextColor()
  {
    currentColorIndex++;
    if (currentColorIndex == bgColors.length) currentColorIndex = 0;
    canvas.beginDraw();
    canvas.background(bgColors[currentColorIndex]);
    canvas.endDraw();
  }

  void prevColor()
  {
    currentColorIndex--;
    if (currentColorIndex < 0) currentColorIndex = bgColors.length - 1;
    canvas.beginDraw();
    canvas.background(bgColors[currentColorIndex]);
    canvas.endDraw();
  }
  
  color setBgColor()
  {
    return bgColors[currentColorIndex];
  }
}
