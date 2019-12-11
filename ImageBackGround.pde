class ImageBackGround
{
  PGraphics canvas;
  int imageCount = 0;

  ImageBackGround()
  {
    canvas = createGraphics(width, height);
    canvas.beginDraw();
    canvas.background(0, 0);
    canvas.image(backgroundImages[imageCount], 0, 0, width, height);
    canvas.endDraw();
    image(backgroundImages[imageCount], 0, 0, width, height);
  }

  void display()
  {
    canvas.beginDraw();
    canvas.background(0, 0);
    canvas.image(backgroundImages[imageCount], 0, 0, width, height);
    canvas.endDraw();
    image(backgroundImages[imageCount], 0, 0, width, height);
  }

  void nextImage()
  {
    imageCount++;
    if (imageCount == backgroundImages.length) imageCount = 0;
    canvas.beginDraw();
    canvas.background(backgroundImages[imageCount]);
    canvas.endDraw();
  }

  void prevImage()
  {
    imageCount--;
    if (imageCount < 0) imageCount = backgroundImages.length - 1;
    canvas.beginDraw();
    canvas.background(backgroundImages[imageCount]);
    canvas.endDraw();
  }
}
