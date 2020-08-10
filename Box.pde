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

  CollisionInfo checkCollision(PVector checkPosition)
  {
    return
      new CollisionInfo
      (
      shader.getColor(PVector.sub(position, checkPosition), dimensions), 
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

  BoxShader()
  {
    this(0);
  }

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

  color getColor(PVector coord, PVector dimensions)
  {
    if (coord.z >= -1)
      return front;
    
    if (coord.z <= -dimensions.z + 1)
      return back;
    
    if (coord.x >= -1)
      return left;
    
    if (coord.x <= -dimensions.x + 1)
      return right;
    
    if (coord.y >= -1)
      return top;
    
    if (coord.y <= -dimensions.y + 1)
      return bottom;
      
    return 0;
  }
}
