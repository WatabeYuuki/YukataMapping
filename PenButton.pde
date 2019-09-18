class PenButton extends Button
{
  float x1, x2, x3, y1, y2;
  int imageNum;

  PenButton(float _x, float _y, float _w, float _h, float _r)
  {
    super(_x, _y, _w, _h, _r);

    imageNum = 0;
  }

  int penImageLength()
  {
    return penImages.length;
  }

  void nextImage()
  {
    imageNum++;
    if  (imageNum == penImageLength()) imageNum = 0;
  }

  void displayContent()
  {
    image(penImages[imageNum], x  + x / 100, y + y / 100, w - w / 4, h - h / 4);
  }
}
