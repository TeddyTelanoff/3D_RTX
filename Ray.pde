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
        radians(angle.y)
      );
    this.step = step;
    this.maxDistance = maxDistance;
    this.px = px;
    this.py = py;

    direction = new PVector
      (
        cos(angle.y) * cos(angle.x) * step,
        cos(angle.y) * sin(angle.x) * step,
        sin(angle.y)                * step
      );
  }
  
  Ray(PVector position, PVector dir, float step, float maxDistance, int px, int py, Object dif)
  {
    this.position = position;
    this.step = step;
    this.maxDistance = maxDistance;
    this.px = px;
    this.py = py;

    direction = dir;
  }

  void update()
  {
    distance++;
    position.add(direction);
    
    //if (distance >= maxDistance)
    //  setPixel(indexOf(px, py), 57);
    
    if (checkCollision())
      setPixel(indexOf(px, py), hitColor);
  }

  boolean alive()
  {
    return !checkCollision() && distance < maxDistance;
  }

  boolean checkCollision()
  {
    for (Shape shape : shapes)
      if (shape.checkCollision(position).hit)
      {
        hitColor = shape.checkCollision(position).col;
        return true;
      }

    return false;
  }
}
