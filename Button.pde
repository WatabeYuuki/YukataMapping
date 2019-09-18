abstract class Button
{
  float x, y, w, h, r;
  color c = color(255);
  color defaultSC = color(230, 230, 230);
  color activeColor = color(255, 0, 0);
  color sC = defaultSC;

  Button(float _x, float _y, float _w, float _h, float _r)
  {
    init(_x, _y, _w, _h, _r);
  }

  void init(float _x, float _y, float _w, float _h, float _r)
  {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    r = _r;
  }

  void displayFrame()
  {
    stroke(sC);
    strokeWeight(2.5);
    fill(c);
    rect (x, y, w, h, r);
  }

  abstract void displayContent();

  void display() 
  {
    pushStyle();
    displayFrame();
    displayContent();
    popStyle();
  }

  boolean isInner(float targetX, float targetY) 
  {
    return (targetX >= x && targetX <= x + w) && (targetY >= y && targetY <= y + h);
  }
  
  void setStrColor(color _sC)
  {
    sC = _sC;
  }
  
  void inactive()
  {
    sC = defaultSC;
  }
  
  void active()
  {
    sC = activeColor;
  }
  
}
