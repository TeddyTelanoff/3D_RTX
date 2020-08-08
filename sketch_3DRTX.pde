ArrayList<Shape> shapes;

final PVector dimensions = new PVector(500, 400);
final PVector rayDimensions = new PVector(dimensions.x, dimensions.y);
final PVector fov = new PVector(120, 90);

void settings()
{
  size((int) dimensions.x, (int) dimensions.y);
}

void setup()
{
  shapes =
    new ArrayList<Shape>()
  {
    {
      add(new Box(new PVector(10, 10, 10), new PVector(100, 100, 100), new BoxShader(#00FF00)));
    }
  };

  background(57);
  loadPixels();
  drawRays(new PVector(0, 0, 0), new PVector(35, 0, -50), 50);
  updatePixels();
}

void draw()
{
  surface.setTitle("3D RayTracing - Treidex | FPS: " + frameRate);
}

void drawRays(PVector position, PVector direction, float maxDistance)
{
  Ray[] rays = new Ray[pixels.length];
  
  for (int y = 0; y < pixelHeight; y += pixelHeight / rayDimensions.y)
    for (int x = 0; x < pixelWidth; x += pixelWidth / rayDimensions.x)
    {
      println("Drawing ray:", x, y);
      
      rays[indexOf(x, y)] =
        new Ray
        (
          new PVector(x, y).sub(PVector.div(rayDimensions, 2)).add(position), 
          new PVector(direction.x - map(x, 0, pixelWidth, -fov.x/2, fov.x/2), direction.y - map(x, 0, pixelHeight, -fov.y/2, fov.y/2), direction.z),
          1, maxDistance, x, y
        );
      do
      {
        rays[indexOf(x, y)].update();
      } 
      while (rays[indexOf(x, y)].alive());
      
      println("Finished ray:", x, y, rays[indexOf(x, y)].position);
   }
}

int indexOf(int x, int y)
{
  if (x < 0 || x >= pixelWidth || y < 0 || y >= pixelHeight)
    throw new IndexOutOfBoundsException("Cannot find pixel at Coordinates: " + x + ", " + y + "!");

  return x + (y * pixelWidth);
}
