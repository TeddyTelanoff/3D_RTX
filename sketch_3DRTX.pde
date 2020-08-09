import static java.awt.event.KeyEvent.*;

ArrayList<Shape> shapes;

final PVector dimensions = new PVector(500, 400);
final PVector rayDimensions = new PVector(dimensions.x, dimensions.y);
final PVector fov = new PVector(120, 90);
final float maxDistance = 250;

final float speed = 6.9;
final float rotationSpeed = 12.4;

PVector position = new PVector(0, 0, 0), rotation = new PVector(-180, -180);

Ray[] rays;

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
      add(new Box(new PVector(10, 10, 100), new PVector(100, 100, 100), new BoxShader(#00FF00)));
      add(new Box(new PVector(-100, -69, 10), new PVector(250, 100, 50), new BoxShader(#FF0000)));
    }
  };

  background(57);
  loadPixels();
  drawRays(position, rotation, maxDistance);
  updatePixels();
}

void draw()
{
  surface.setTitle("3D RayTracing - Treidex | FPS: " + frameRate);
}

void keyReleased()
{
  switch(keyCode)
  {
    case VK_LEFT:
      rotate(new PVector(-rotationSpeed, 0));
      break;
    case VK_RIGHT:
      rotate(new PVector( rotationSpeed, 0));
      break;
    case VK_UP:
      rotate(new PVector(0, -rotationSpeed));
      break;
    case VK_DOWN:
      rotate(new PVector(0,  rotationSpeed));
      break;
      
    case VK_A:
      move(new PVector(-speed, 0, 0));
      break;
    case VK_D:
      move(new PVector( speed, 0, 0));
      break;
    case VK_W:
      move(new PVector(0, 0, -speed));
      break;
    case VK_S:
      move(new PVector(0, 0, speed));
      break;
    case VK_SPACE:
      move(new PVector(0, -speed, 0));
      break;
    case VK_SHIFT:
      move(new PVector(0,  speed, 0));
      break;
  }
}

void move(PVector direction)
{
  position.add(direction);
  
  background(57);
  loadPixels();
  drawRays(position, rotation, 250);
  updatePixels();
}

void rotate(PVector direction)
{
  rotation.add(direction);
  
  background(57);
  loadPixels();
  drawRays(position, rotation, 250);
  updatePixels();
}

void drawRays(PVector position, PVector rotation, float maxDistance)
{
  rays = new Ray[pixels.length];
  
  for (int y = 0; y < pixelHeight/2; y += pixelHeight / rayDimensions.y)
    for (int x = 0; x < pixelWidth; x += pixelWidth / rayDimensions.x)
    {
      //println("Drawing ray:", x, y);
      
      rays[indexOf(x, y)] =
        new Ray
        (
          //position,
          //PVector.div(rayDimensions, 2).add(position),
          new PVector(x, y).sub(PVector.div(rayDimensions, 2)).add(position), 
          //new PVector(rotation.x - map(x, 0, pixelWidth, -fov.x/2, fov.x/2), rotation.y - map(x, 0, pixelHeight, -fov.y/2, fov.y/2)),
          rotation,
          1, maxDistance, x, y
        );
      do
      {
        rays[indexOf(x, y)].update();
      } 
      while (rays[indexOf(x, y)].alive());
      
      //println("Finished ray:", x, y, rays[indexOf(x, y)].position);
   }
}

int indexOf(int x, int y)
{
  if (x < 0 || x >= pixelWidth || y < 0 || y >= pixelHeight)
    throw new IndexOutOfBoundsException("Cannot find pixel at Coordinates: " + x + ", " + y + "!");

  return x + (y * pixelWidth);
}
