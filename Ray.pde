class Ray
{
  PVector angle;
  PVector position;
  PVector direction;
  float distance;
  float maxDistance;
  float step;

  int px, py;

  color hitColor;

  Ray(PVector position, PVector angle, float step, float maxDistance, int px, int py)
  {
    this.position = position;
    this.angle =
      new PVector
      (
      radians(angle.x), 
      radians(angle.y), 
      radians(angle.z)
      );
    this.step = step;
    this.maxDistance = maxDistance;
    this.px = px;
    this.py = py;

    direction = new PVector
      (
      sin(angle.x) * step, 
      cos(angle.y) * step, 
      sin(angle.z) * step
      );
  }

  void update()
  {
    distance++;
    position.add(direction);
    if (checkCollision())
    {
      pixels[indexOf(px, py)] = hitColor;
    }
  }

  boolean alive()
  {
    return !checkCollision() && (distance < maxDistance);
  }

  boolean checkCollision()
  {
    for (Shape shape : shapes)
      if (shape.checkCollision(position, direction).hit)
      {
        hitColor = shape.checkCollision(position, direction).col;
        return true;
      }

    return false;
  }
}
