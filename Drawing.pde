DrawThread[] threads = {};
boolean reDraw;

void drawRays()
{
  boolean draw = true;
  for (DrawThread thread : threads)
    if (thread.isAlive())
      draw = false;
  if (draw)
  {
    reDraw = false;
    
    rays = new Ray[width * height];
    
    threads =
      new DrawThread[]
      {
        new DrawThread("1", 0, width, 0         , height/4  , true, true),
        new DrawThread("2", 0, width, height/2  , height/4  , true, false),
        new DrawThread("3", 0, width, height/2  , height/4*3, true, true),
        new DrawThread("4", 0, width, height-1  , height/4*3, true, false)
      };
    for (DrawThread thread : threads)
      thread.start();
    
    background(0x39);
  }
}

void move(PVector direction)
{
  position.add(direction);
  
  reDraw = true;
  drawRays();
}

void rotate(PVector direction)
{
  rotation.add(direction);
  
  reDraw = true;
  drawRays();
}

void drawRay(int x, int y)
{
  if (reDraw)
      return;
  rays[indexOf(x, y)] =
    new Ray
    (
      new PVector(x, y).sub(PVector.div(rayDimensions, 2)).add(position),
      rotation,
      1, maxDistance, x, y
    );
  do
  {
    if (reDraw)
      return;
    rays[indexOf(x, y)].update();
  } 
  while (rays[indexOf(x, y)].alive());
}

synchronized void pixels()
{
  updatePixels();
  loadPixels();
}

void setPixel(int index, color col)
{
  //loadPixels();
  pixels[index] = col;
  //updatePixels();
}
