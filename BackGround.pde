class BackGround
{
  PGraphics canvas;
  int currentColorIndex = 0;
  color[] bgColors;
  int imageCount = 0;

  BackGround(color[] _bgColors)
  {
    bgColors = _bgColors;
    canvas = createGraphics(width, height);
    canvas.beginDraw();
    canvas.background(bgColors[currentColorIndex]);
    canvas.endDraw();
  }

  void display()
  {
    if (!BACKGROUND_MODE)
    {
      background(bgColors[currentColorIndex]);
    } else if (BACKGROUND_MODE)
    {
      background(backgroundImages[imageCount]);
    }
    canvas.background(bgColors[currentColorIndex]);
    //image(canvas, 0, 0);
  }

  void nextColor()
  {
    if (!BACKGROUND_MODE)
    {
      currentColorIndex++;
      if (currentColorIndex == bgColors.length) currentColorIndex = 0;
      canvas.beginDraw();
      canvas.background(bgColors[currentColorIndex]);
      canvas.endDraw();
    } else if (BACKGROUND_MODE)
    {
      imageCount++;
      if (imageCount == backgroundImages.length) imageCount = 0;
      canvas.beginDraw();
      canvas.background(backgroundImages[imageCount]);
      canvas.endDraw();
    }
  }

  void prevColor()
  {
    if (!BACKGROUND_MODE)
    {
    currentColorIndex--;
    if (currentColorIndex < 0) currentColorIndex = bgColors.length - 1;
    canvas.beginDraw();
    canvas.background(bgColors[currentColorIndex]);
    canvas.endDraw();
    }
    if (BACKGROUND_MODE)
    {
    imageCount--;
    if (imageCount < 0) imageCount = backgroundImages.length - 1;
    canvas.beginDraw();
    canvas.background(backgroundImages[imageCount]);
    canvas.endDraw();
    }
  }

  color setBgColor()
  {
    return bgColors[currentColorIndex];
  }
}
