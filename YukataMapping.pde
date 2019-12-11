//import gab.opencv.*;
import codeanticode.syphon.*;
import SimpleOpenNI.*;

SimpleOpenNI  context;

BackGround backGround;
ImageBackGround imageBackGround;

Drawing drawing;

PlusButton plusButton;
MinusButton minusButton;

PenButton penButton;

MoveStampButton moveStampButton;
Anime anime;
final int DRAW_MODE = 0;
final int ANIME_MODE = 1;
final boolean MOVE_PEN_MODE = false;
boolean BACKGROUND_MODE = false;

PreviewButton previewButton;

int drawingMode;

PImage[] stampImages;
PImage[] penImages;
PImage[] backgroundImages;

float threshold = 0.1;

SyphonServer server;
//OpenCV opencv;

void setup()
{
  size (640, 480, P2D);

  server = new SyphonServer(this, "Processing Syphon");

  context = new SimpleOpenNI(this);
  context.enableDepth();
  context.enableUser();

  //opencv = new OpenCV(this, context.userWidth(), context.userHeight());

  backGround = new BackGround(colors);

  drawing = new Drawing();

  int BUTTON_NUM = 18;
  int j = 0, i = 0;
  cbs = new ColorButton[BUTTON_NUM];
  for (int count = 0; count < BUTTON_NUM; count++, i++)
  {
    float x = width - width / 10 + (width / 25 * j) + 2.5 * j;
    float y = height - height / 1.75 + (height / 25 * i) + 2.5 * i;
    cbs[count] = new ColorButton(colors[count], x, y, width / 25, height / 25);
    cbs[count].setRadius(7);
    if (count == 8) i = -1;
    if (count == 8) j = 1;
  }

  plusButton = new PlusButton(0, height -height / 10, width / 10, height / 10, 7);
  minusButton = new MinusButton(width / 10, height -height / 10, width / 10, height / 10, 7);
  float xSize1 = width / 30;
  float xSize2 = width / 20;
  float xSize3 = width / 15;
  float ySize1 = height / 30;
  float ySize2 = height / 15;
  minusButton.getSize(xSize1, xSize2, xSize3, ySize1, ySize2);
  plusButton.getSize(xSize1, xSize2, xSize3, ySize1, ySize2);

  moveStampButton = new MoveStampButton(width - width / 10, height -height / 10, width / 10, height / 10, 7);
  anime = new Anime();

  stampImages = new PImage[stampImagePaths.length];
  for (i = 0; i < stampImagePaths.length; i++) 
  {
    stampImages[i] = loadImage(stampImagePaths[i]);
  }

  backgroundImages = new PImage[backgroundImagePaths.length];
  for (i = 0; i < backgroundImagePaths.length; i++)
  {
    backgroundImages[i] = loadImage(backgroundImagePaths[i]);
    backgroundImages[i].resize(width, height);
  }
  imageBackGround = new ImageBackGround();

  //cartoonPen = new ArrayList<Integer>();
  //cartoonStrokeWeight = new ArrayList<Integer>();
  penImages = new PImage[penImagePaths.length];
  for (i = 0; i < penImagePaths.length; i++) 
  {
    penImages[i] = loadImage(penImagePaths[i]);
  }

  drawingMode = DRAW_MODE;

  penButton = new PenButton(width - 2 *(width / 10) - 2.5, height -height / 10, width / 10, height / 10, 7);

  previewButton = new PreviewButton((width / 2) - (width / 10), height -height / 10, width / 5, height / 10, 7);

  penButton.active();
  moveStampButton.inactive();
  smooth();
}

void draw()
{
  context.update();

  backGround.display();
  if (BACKGROUND_MODE) imageBackGround.display();
  drawing.display();
  anime.display();
  for (ColorButton cb : cbs) 
  {
    cb.display();
  }
  plusButton.display();
  minusButton.display();

  moveStampButton.display();
  penButton.display();
  previewButton.display();
  server.sendImage(cerateMergedImage());
}

PImage cerateMergedImage() {
  PGraphics pg = createGraphics(drawing.canvas.width, drawing.canvas.height);

  PImage depthImage = context.depthImage().copy();
  float ratio = depthImage.height / pg.height;
  float w = depthImage.width * ratio;
  float h = pg.height;
  depthImage.loadPixels();
  depthImage.resize((int)w, (int)h);
  depthImage.updatePixels();
  //float thc = map(mouseX, 0, width, 0, 10);
  //thc = thc / 10;
  //depthImage.filter(THRESHOLD, thc);
  //println(thc);
  depthImage.filter(THRESHOLD, threshold);


  pg.beginDraw();
  pg.image(backGround.canvas, 0, 0);
  
  if (BACKGROUND_MODE) pg.image(imageBackGround.canvas, 0, 0);
  
  pg.image(drawing.canvas, 0, 0);
  pg.image(anime.canvas, 0, 0);
  
  pg.scale(1, -1);
  pg.mask(depthImage);
  pg.endDraw();

  return pg;
}

void mouseDragged() 
{
  if (drawingMode == DRAW_MODE) 
  {
    pmouseX = pmouseX == 0 ? mouseX: pmouseX;
    pmouseY = pmouseY == 0 ? mouseY: pmouseY;
    drawing.drawing(mouseX, mouseY, pmouseX, pmouseY);
  }
  if (drawingMode == ANIME_MODE && !moveStampButton.isInner(mouseX, mouseY) 
    && !penButton.isInner(mouseX, mouseY) && !plusButton.isInner(mouseX, mouseY) 
    && !minusButton.isInner(mouseX, mouseY) && !previewButton.isInner(mouseX, mouseY)) 
    anime.addArray(mouseX, mouseY);
}

void mousePressed()
{
  if (drawingMode == ANIME_MODE && !moveStampButton.isInner(mouseX, mouseY) 
    && !penButton.isInner(mouseX, mouseY) && !plusButton.isInner(mouseX, mouseY) 
    && !minusButton.isInner(mouseX, mouseY) && !previewButton.isInner(mouseX, mouseY)) 
    anime.trace();
}

void mouseReleased() 
{
  if (drawingMode == DRAW_MODE) 
  {
    if (moveStampButton.isInner(mouseX, mouseY)) 
    {
      drawingMode = ANIME_MODE;
      penButton.inactive();
      moveStampButton.active();
    }
    if (penButton.isInner(mouseX, mouseY)) 
    {
      drawing.setPenMode();
      penButton.nextImage();
    }
    if (plusButton.isInner(mouseX, mouseY)) drawing.setPlus();
    if (minusButton.isInner(mouseX, mouseY)) drawing.setMinus();
    for (ColorButton cb : cbs) 
    {
      if (cb.isInner(mouseX, mouseY)) drawing.setColor(cb.getColor());
    }
  } else if (drawingMode == ANIME_MODE)
  {
    if (penButton.isInner(mouseX, mouseY)) 
    {
      drawingMode = DRAW_MODE;
      penButton.active();
      moveStampButton.inactive();
    }
    if (plusButton.isInner(mouseX, mouseY)) anime.setPlus();
    if (minusButton.isInner(mouseX, mouseY)) anime.setMinus();
    else anime.setMoveMode();
  }
}

void keyPressed() 
{
  if (key == 'c') 
  {
    drawing.clear();
    anime.clear();
  }
  if (!BACKGROUND_MODE && key == '.') backGround.nextColor();
  else if (BACKGROUND_MODE && key == '.') imageBackGround.nextImage();
  if (!BACKGROUND_MODE && key == ',') backGround.prevColor();
  else if (BACKGROUND_MODE && key == ',') imageBackGround.prevImage();
  if (key == 'x')
  {
    anime.nextImage();
    moveStampButton.nextImage();
  }
  if (key == 'z') 
  {
    anime.prevImage();
    moveStampButton.prevImage();
  }
  if (key == 'b')
  {
    if (BACKGROUND_MODE) BACKGROUND_MODE = false;
    else BACKGROUND_MODE = true;
  }
  if (key == '[') threshold += 0.1;
  if (key == ']' && threshold > 0.1) threshold -= 0.1;
}
