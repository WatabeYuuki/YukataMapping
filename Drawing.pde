Integer[] penMode;
//ArrayList<Integer> pens;
//ArrayList<Integer> cartoonPen;
//ArrayList<Integer> cartoonStrokeWeight;

class Drawing
{
  PGraphics canvas;
  int penColor;
  float strWeight;
  float sWstate;
  int LINE_MODE = 0;
  int POINT_MODE = 1;
  int FUDE_MODE = 2;
  //int CARTOON_MODE = 3;
  int penModeCount = 2;
  int penMode;
  int modeState;
  //boolean cartoonModeSwitch = false;
  //int cartoonCount = 0;
  //int cartoonRCount = 0;
  //int cartoonX;
  //int cartoonY;
  //int cartoonPX;
  //int cartoonPY;
  //int cartoonR;
  int weightCount = 1;

  Drawing()
  {
    canvas = createGraphics(600, 600);
    canvas.beginDraw();
    canvas.background(0, 0);
    canvas.endDraw();

    sWstate = 5;
    strWeight = sWstate;
    penColor = color(255, 255, 255);
    penMode = LINE_MODE;
    modeState = 0;
  }

  void clear() 
  {
    canvas.beginDraw();
    canvas.background(0, 0);
    //cartoonPen.clear();
    //cartoonStrokeWeight.clear();
    canvas.endDraw();
  }

  void drawing(int x, int y, int px, int py) 
  {
    canvas.beginDraw();
    if (penMode == LINE_MODE) lineMode(x, y, px, py);
    if (penMode == POINT_MODE) pointMode(x, y, px, py);
    if (penMode == FUDE_MODE) fudeMode(x, y, px, py);
    //if (penMode == CARTOON_MODE) cartoonMode(x, y, px, py);
    //if (cartoonModeSwitch == true)
    //{
    //  //cartoonMove();
    //  //cartoonDisplay();
    //  //cartoonRemove();
    //  //cartoonDisplayReset();
    //}
    canvas.endDraw();
  }

  void lineMode(int x, int y, int px, int py)
  {
    canvas.strokeWeight (strWeight);
    canvas.stroke (penColor);
    canvas.line(x, y, px, py);
  }

  void pointMode(int x, int y, int px, int py)
  {
    float w = dist(x, y, px, py);
    w = constrain (w, 0, 500);
    w = map(w, 0, 500, 100, 0);
    canvas.strokeWeight (strWeight * w / 50);
    canvas.stroke (penColor, 80);
    canvas.line(x, y, px, py);
  }

  //void cartoonMode(int _x, int _y, int _px, int _py)
  //{   
  //  cartoonPen.add(_px);
  //  cartoonPen.add(_py);
  //  cartoonPen.add(_x);
  //  cartoonPen.add(_y);
  //  cartoonModeSwitch = true;
  //}

  //void cartoonMove()
  //{
  //  // update
  //  if (cartoonCount < cartoonPen.size())
  //  {
  //    cartoonPX = cartoonPen.get(cartoonCount);
  //    cartoonPY = cartoonPen.get(cartoonCount + 1);
  //    cartoonX = cartoonPen.get(cartoonCount + 2);
  //    cartoonY = cartoonPen.get(cartoonCount + 3);
  //    cartoonCount += 4;
  //  } else cartoonCount = 0;
  //}

  //void cartoonRemove()
  //{
  //  if (cartoonRCount <cartoonStrokeWeight.size())
  //  {
  //    cartoonR = cartoonStrokeWeight.get(cartoonRCount);
  //    cartoonRCount += 1;
  //  } else cartoonRCount = 0;
  //}

  //void cartoonDisplay()
  //{
  //  int  r = int(random(-5, 5));
  //  cartoonStrokeWeight.add(r);
  //  canvas.strokeWeight (strWeight + r);
  //  canvas.stroke (penColor);
  //  canvas.line(cartoonX, cartoonY, cartoonPX, cartoonPY);
  //}

  //void cartoonDisplayReset()
  //{
  //  canvas.strokeWeight(cartoonR + 1);
  //  canvas.stroke (0);
  //  canvas.line(cartoonX, cartoonY, cartoonPX, cartoonPY);
  //}

  void fudeMode(int x, int y, int px, int py)
  {
    float X = abs(1.5*(x - px));
    float Y = abs(1.5*(y - py));
    int Z = int(X + Y);
    Z = constrain(Z, 0, 100);
    float s = map(Z, 0, 100, 0, 5);
    canvas.strokeWeight (strWeight - s * weightCount);
    canvas.stroke (penColor);
    canvas.line(x, y, px, py);
  }

  void display()
  {
    image(canvas, 0, 0);
  }

  void setColor(color _Color)
  {
    this.penColor = _Color;
  }

  void setPlus()
  {
    if (strWeight < sWstate * 5) 
    {
      strWeight += sWstate;
      weightCount++;
      plusButton.setRect(255);
      minusButton.setRect(255);
    } 
    if (weightCount == 5) plusButton.setRect(128);
  }

  void setMinus()
  {
    if (strWeight > sWstate) 
    {
      strWeight -= sWstate;
      weightCount--;
      minusButton.setRect(255);
      plusButton.setRect(255);
    } 
    if (weightCount == 1) minusButton.setRect(128);
  }

  void setPenMode()
  {
    modeState++;
    if (modeState > penModeCount) modeState = 0;
    penMode = modeState;
  }
  
  color setPenColor()
  {
    return penColor;
  }
  
  float setStrWeight()
  {
    return strWeight;
  }
}
