interface Shape
{
  CollisionInfo checkCollision(PVector checkPosition, PVector direction);
}

interface Shader
{
  color getColor(PVector direction);
}
