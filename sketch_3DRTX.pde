import static java.awt.event.KeyEvent.*;

ArrayList<Shape> shapes;

final PVector light = new PVector();
final PVector dimensions = new PVector(500, 400);
final PVector rayDimensions = new PVector(dimensions.x, dimensions.y);
final PVector fov = new PVector(0.5, 0.5);
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
  drawRays();
}

void draw()
{
  surface.setTitle("3D RayTracing - Treidex | FPS: " + frameRate);
  
  if (reDraw)
  {
    background(0x39);
    drawRays();
  }
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

int indexOf(int x, int y)
{
  if (x < 0 || x >= width || y < 0 || y >= height)
    throw new IndexOutOfBoundsException("Cannot find pixel at Coordinates: " + x + ", " + y + "!");

  return x + (y * pixelWidth);
}
