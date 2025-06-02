class Polygon extends AFieldObject {
 private int type;
 private int xpStored;
 
 public Polygon(int team, PVector position, PVector speed, PVector direction, color objColor, int size,int type, int xPt) {
   super(TYPE_POLY, TEAM_POLY, position, speed, direction, 1000000000, objColor, size);
   xpStored = xPt;
    if (type == 3) {  
      this.type = 5;
      xpStored = 5;
    } else if (type == 2) {  // Square
      this.type = 4;
      xpStored = 10;
    } else { 
      this.type = 3;
      xpStored = 20;
    } 
  
   
 }
  
  public boolean isTouching(AFieldObject other) {
    if (other.getType() == TYPE_PLAYER) {
      if (distanceTo(other) <= getSize() + other.getSize()) {
        other.takeDamage(3);
        this.takeDamage(3);
        System.out.println("took damage");
        return true;
      }
    }
    if (other.getType() == TYPE_BULLET) {
      return distanceTo(other) <= getSize() + other.getSize();
    }
    
    return false;
  }

public void render() {
  fill(getColor());
  stroke(10);
  float angle = TWO_PI / type;
  beginShape();
  for (int i = 0; i < type; i++) {
    float sx = getPosition().x + cos(angle * i) * getSize();
    float sy = getPosition().y + sin(angle * i) * getSize();
    vertex(sx, sy);
  }
  endShape(CLOSE);
  System.out.println(type);
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
