class Box implements Shape
{
  PVector position;
  PVector dimensions;
  BoxShader shader;

  Box(PVector position, PVector dimensions, BoxShader shader)
  {
    this.position = position;
    this.dimensions = dimensions;
    this.shader = shader;
  }

  CollisionInfo checkCollision(PVector checkPosition, PVector direction)
  {
    return
      new CollisionInfo
      (
      shader.getColor(direction), 
      (
      (checkPosition.x >= position.x && checkPosition.x <= position.x + dimensions.x) // X
      &&
      (checkPosition.y >= position.y && checkPosition.y <= position.y + dimensions.y) // Y
      &&
      (checkPosition.z >= position.z && checkPosition.z <= position.z + dimensions.z) // Z
      )
      );
  }
}

class BoxShader implements Shader
{
  color front, back, left, right, top, bottom;

  BoxShader(color col)
  {
    this(col, col, col, col, col, col);
  }

  BoxShader(color front, color back, color left, color right, color top, color bottom)
  {
    this.front = front;
    this.back = back;
    this.left = left;
    this.right = right;
    this.top = top;
    this.bottom = bottom;
  }

  color getColor(PVector direction)
  {
    final byte X = 0, Y = 1, Z = -1;
    byte greatest = X;

    if (direction.x > direction.y && direction.x > direction.z)
      greatest = X;
    if (direction.y > direction.x && direction.y > direction.z)
      greatest = Y;
    if (direction.z > direction.x && direction.z > direction.y)
      greatest = Z;

    switch(greatest)
    {
    case X:
      return direction.x < 0 ? back : front;
    case Y:
      return direction.y < 0 ? left : right;
    case Z:
      return direction.z < 0 ? top : bottom;

    default:
      return front;
    }
  }
}
