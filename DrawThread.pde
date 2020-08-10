class DrawThread extends Thread
{
  int xm, xM, ym, yM;
  boolean xp, yp;
  
  DrawThread(String name, int xm, int xM, int ym, int yM, boolean xp, boolean yp)
  {
    super(name);
    
    this.xm = xm;
    this.xM = xM;
    this.ym = ym;
    this.yM = yM;
    
    this.xp = xp;
    this.yp = yp;
  }
  
  public void run()
  {
    if (yp)
      for (int y = ym; y < yM; y += height / rayDimensions.y)
      {
        if (xp)
          for (int x = xm; x < xM; x += width / rayDimensions.x)
            drawRay(x, y);
       else
         for (int x = xm; x >= xM; x -= width / rayDimensions.x)
            drawRay(x, y);
      }
    else
      for (int y = ym; y >= yM; y -= height / rayDimensions.y)
      {
        if (xp)
          for (int x = xm; x < xM; x += width / rayDimensions.x)
            drawRay(x, y);
       else
         for (int x = xm; x >= xM; x -= width / rayDimensions.x)
           drawRay(x, y);
      }
    println("Finished Drawing Thread", getName() + "!");
  }
}
