class Ellipsoid implements Shape
{
  PVector position;
  PVector dimensions;
  Shader shader;
  
  Ellipsoid(PVector position, PVector dimensions, Shader shader)
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
        sqrt
        (
          pow((checkPosition.x - position.x), 2)/pow(dimensions.x, 2) // X
            +
          pow((checkPosition.y - position.y), 2)/pow(dimensions.y, 2) // Y
            +
          pow((checkPosition.z - position.z), 2)/pow(dimensions.z, 2) // Z
        ) <= 1
      );
  }
}
