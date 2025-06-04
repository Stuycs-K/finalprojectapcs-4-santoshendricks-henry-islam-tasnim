class Polygon extends AFieldObject {
 private int type;
 private int xpStored;
 private float cooldown;
 
 public Polygon(int team, PVector position, PVector speed, PVector direction, color objColor, int size,int type, int xPt) {
   super(TYPE_POLY, TEAM_POLY, position, speed, direction, 100, objColor, size);
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
    cooldown = -1.0;
  
   
 }
  
  public boolean isTouching(AFieldObject other) {
    if (other.getType() == TYPE_PLAYER) {
      if (distanceTo(other) <= getSize() + other.getSize()) {
        if (cooldown <= 0.0) {
          other.takeDamage(5);
          this.takeDamage(5);
          cooldown = 40.0;
          System.out.println("took damage");
        }
        return true;
      }
    }
    if (other.getType() == TYPE_BULLET) {
      if (distanceTo(other) <= getSize() + other.getSize()) {
        other.isTouching(this);
      }
    }
    
    return false;
  }

public void render() {
  fill(getColor());
  stroke(10);
  float angle = TWO_PI / type;
  beginShape();
  for (int i = 0; i < type; i++) {
  float sx = getPosition().x + cos(angle * i) * getSize() *2 ;
    float sy = getPosition().y + sin(angle * i) * getSize() * 2;
    vertex(sx, sy);
  }
  endShape(CLOSE);
  if (getHp() < getMaxHp()) {
    
    noStroke();
    rectMode(CORNER);
    fill(100, 100, 100);
    rect(getX() - getSize() * 2, getY() + getSize() * 2 + 10, 4 * getSize(), 13);
    if (getHp() > getMaxHp() * 0.75) {
      fill(0, 200, 0);
    } else if (getHp() > getMaxHp() * 0.5) {
      fill(200, 200, 0);
    } else if (getHp() > getMaxHp() * 0.25) {
      fill(200, 100, 0);
    } else {
      fill(200, 0, 0);
    }
    rect(getX() - getSize() * 2, getY() + getSize() * 2 + 10, 4 * getSize() * ((float)getHp() / getMaxHp()), 13);
    stroke(10);
    rectMode(CENTER);
  }
  //System.out.println(type);
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
   
   // check if touching player or bullet
   for (int i = 0; i < field.objects.size(); i++) {
       isTouching(field.objects.get(i));
           
   }
   isTouching(field.user);

  if (cooldown > 0.0) cooldown -= 1.0;
  //System.out.println(cooldown);
   setPosition(pos);
}
public int getXPStored() { 

  return xpStored; }




}
