class PreviewButton extends Button
{
  float x1, x2, x3, y1, y2;
  float strWeight;
  color penColor;
  color bgColor;

  PreviewButton(float _x, float _y, float _w, float _h, float _r)
  {
    super(_x, _y, _w, _h, _r);
  }
  
    void displayContent()
  {
    c  = backGround.setBgColor();
    strWeight = drawing.setStrWeight();
    penColor = drawing.setPenColor();
        strokeWeight (strWeight);
    stroke (penColor);
    line(x + (width / 30), y + (height / 20), x + (width / 15) * 2 + (width / 30), y + (height / 20));
  }
}
