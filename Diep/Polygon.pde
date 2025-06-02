class Polygon extends AFieldObject {
 private int type;
 private int xpStored;
 
 public Polygon(int team, PVector position, PVector speed, PVector direction, color objColor, int size,int type, int xPt) {
   super(2, 0, position, speed, direction, 100, objColor, size);
   xpStored = xPt;
    if (type == 3) {  
      type = 5;
      xpStored = 5;
    } else if (type == 2) {  // Square
      type = 4;
      xpStored = 10;
    } else { 
      type = 3;
      xpStored = 20;
    } 
  
   
 }
  
public boolean isTouching(AFieldObject other) {
  return PVector.dist(getPosition(), other.getPosition()) <= getSize() + other.getSize();
}

public void render() {
  fill(getColor());
  stroke(0);
  float angle = TWO_PI / type;
  beginShape();
  for (int i = 0; i < type; i++) {
    float sx = getPosition().x + cos(angle * i) * getSize();
    float sy = getPosition().y + sin(angle * i) * getSize();
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

public void tick(Field field) {
  PVector pos = getPosition();
  PVector vel = getSpeed();
  pos.add(vel);
  setPosition(pos);
    // clamp inside world boundaries
   pos = getPosition();
   pos.x = constrain(pos.x, -field.fWidth/2, field.fWidth/2);
   pos.y = constrain(pos.y, -field.fHeight/2, field.fHeight/2);

   setPosition(pos);
}
public int getXPStored() { 

  return xpStored; }




}
