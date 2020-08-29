interface Shape
{
  CollisionInfo checkCollision(PVector checkPosition);
}

interface Shader
{
  color getColor(PVector coord, PVector dimensions);
}
