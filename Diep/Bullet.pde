class Bullet extends AFieldObject {
  private int dmg;
  private double lifeTimer;
  
  public Bullet(int team, PVector position, PVector speed, PVector direction, color objColor, int size, int dmg, double time) {
    super(TYPE_BULLET, team, position, speed, direction, 1, objColor, size);
    this.dmg = dmg;
    lifeTimer = time;
  }
  
  public void render() {
    fill(getColor());
    circle((float)getX(), (float)getY(), (float)getSize());
  }
  
public void tick(Field field) {
  tickPos(field);

  // Delete if outside world border
  if (getX() < -field.fWidth/2 || getX() > field.fWidth/2 || getY() < -field.fHeight/2 || getY() > field.fHeight/2) {
    takeDamage(1); 
  }

  // Check for bullet-bullet collision
  for (int i = 0; i < field.objects.size(); i++) {
    AFieldObject other = field.objects.get(i);
    if (other != this && other.getType() == TYPE_BULLET && other.getTeam() != getTeam()) {
      if (isTouching(other)) {
        takeDamage(1);
        other.takeDamage(1);
      }
    }
  }
  
  // check if ran out of time
  if (lifeTimer <= 0.0) {
    takeDamage(10);
  }
  lifeTimer -= 1.0;
}
  
  public boolean isTouching(AFieldObject other) {
    if (other.getType() == TYPE_PLAYER) {
      if (distanceTo(other) <= getSize() + other.getSize()) {
        if (other.takeDamage(dmg)) {
          other.setKilledByTeam(getTeam());
        }
        //System.out.println("took damage");
        return true;
      }
    }
    if (other.getType() == TYPE_BULLET) {
      return distanceTo(other) <= getSize() + other.getSize();
    }
    if (other.getType() == TYPE_POLY) {
      if (distanceTo(other) <= getSize() + other.getSize()) {
        if (other.takeDamage(dmg)) {
          other.setKilledByTeam(getTeam());
        }
        takeDamage(10);
      }
    }
    
    return false;
  }
  
  public int getDmg() {
    return dmg;
  }
  
}
    
    
