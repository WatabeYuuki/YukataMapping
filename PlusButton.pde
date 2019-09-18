class PlusButton extends Button
{
  float x1, x2, x3, y1, y2;

  PlusButton(float _x, float _y, float _w, float _h, float _r)
  {
    super(_x, _y, _w, _h, _r);
  }

  void displayContent()
  {
    stroke(0, 0, 0);
    triangle (x + x1, y + y2, x + x2, y + y1, x + x3, y + y2);
  }

  void getSize(float xSize1, float xSize2, float xSize3, float ySize1, float ySize2)
  {
    x1 = xSize1;
    x2 = xSize2;
    x3 = xSize3;
    y1 = ySize1;
    y2 = ySize2;
  }
  
    void setRect(color _c)
  {
    c = _c;
  }
}
