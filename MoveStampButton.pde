class MoveStampButton extends Button
{
  float x1, x2, x3, y1, y2;
  int imageNum;

  MoveStampButton(float _x, float _y, float _w, float _h, float _r)
  {
    super(_x, _y, _w, _h, _r);

    imageNum = 0;
  }

  int imageLength()
  {
    return stampImages.length;
  }

  void nextImage()
  {
    imageNum++;
    if  (imageNum == imageLength()) imageNum = 0;
  }

  void prevImage()
  {
    imageNum--;
    if  (imageNum < 0) imageNum = imageLength() -1;
  }

  void displayContent()
  {
    image(stampImages[imageNum], x  + x / 100, y + y / 100, w - w / 4, h - h / 4);
  }
  
  void setAnimeMode()
  {
    drawingMode = ANIME_MODE;
  }
}
