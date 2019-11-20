class Anime
{
  PGraphics canvas;
  int x, y, px, py, x_direction = 1;
  int imageNum, count;
  int MOVE_MODE = 0;
  int TRACE_MODE = 1;
  int animeMode;
  int imageSize;
  int sizeState;
  int sizeMax;
  int sizeMin;
  int sizeCount = 1;
  ArrayList<Integer> stamp = new ArrayList<Integer>();

  Anime()
  {
    imageNum = 0;
    animeMode = TRACE_MODE;
    sizeState = 10;
    imageSize = 40;
    sizeMax = imageSize + sizeState * 4;
    sizeMin = imageSize;
    canvas = createGraphics(width, height);
    canvas.beginDraw();
    canvas.background(0, 0);
    canvas.endDraw();
  }

  void addArray(int _mx, int _my)
  {
    stamp.add(_mx);
    stamp.add(_my);
  }

  void setTraceMode()
  {
    animeMode = TRACE_MODE;
  }

  void setMoveMode()
  {
    animeMode = MOVE_MODE;
  }

  void clearArray()
  {
    stamp.clear();
  }

  void clearCount()
  {
    count = 1;
  }

  void trace()
  {
    clearArray();
    clearCount();
    setTraceMode();
  }

  int imageLength()
  {
    return stampImages.length;
  }

  void move()
  {
    if (count > stamp.size() - 1 || count == 0) {
      count = 1;
      return;
    }

    // update
    x = stamp.get(count - 1);
    y = stamp.get(count);
    if (x - px < 0) x_direction = -1;
    else x_direction = 1;
    px = x;
    py = y;
    count += 2;
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

  void run()
  {
    pushMatrix();
    imageMode(CENTER);
    translate(x, y);
    scale(x_direction, 1);
    image(stampImages[imageNum], 0, 0, imageSize, imageSize);
    canvas.beginDraw();
    canvas.background(0, 0);
    canvas.imageMode(CENTER);
    canvas.translate(x, y);
    canvas.scale(x_direction, 1);
    canvas.image(stampImages[imageNum], 0, 0, imageSize, imageSize);
    canvas.endDraw();
    popMatrix();
  }

  void display()
  {
    // draw
    if (animeMode == MOVE_MODE && stamp.size() != 0)
    {
      pushStyle();
      move();
      run();
      popStyle();
    }
  }

  void clear()
  {
    stamp.clear();
    stamp.add(-1000);
    stamp.add(-1000);
  }

  void setPlus()
  {
    if (imageSize < sizeMax) 
    {
      imageSize += sizeState;
      sizeCount++;
      plusButton.setRect(255);
      minusButton.setRect(255);
    } 
    if (sizeCount == 5) plusButton.setRect(128);
  }

  void setMinus()
  {
    if (imageSize > sizeMin) 
    {
      imageSize -= sizeState;
      sizeCount--;
      minusButton.setRect(255);
      plusButton.setRect(255);
    } 
    if (sizeCount == 1) minusButton.setRect(128);
  }
}
