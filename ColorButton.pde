ColorButton[] cbs;

class ColorButton extends Button
{

  ColorButton(color colors, float X, float Y, float W, float H)
  {
    super(X, Y, W, H, 0);
    c = colors;
  }

  ColorButton(color colors, float X, float Y, float W, float H, float R)
  {
    super(X, Y, W, H, R);
    c = colors;
  }

  void setRadius(float _r)
  {
    r = _r;
  }
  
    void displayContent()
  {
    
  }

  color getColor() 
  {
    return c;
  }
}
