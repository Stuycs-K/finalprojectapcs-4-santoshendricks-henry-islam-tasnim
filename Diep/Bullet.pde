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
    lifeTimer -= 1.0;
    if (lifeTimer <= 0.0) {
      takeDamage(10);
    }
  }
  
  public boolean isTouching(AFieldObject other) {
    if (other.getType() == TYPE_PLAYER) {
      if (distanceTo(other) <= getSize() + other.getSize()) {
        other.takeDamage(dmg);
        System.out.println("took damage");
        return true;
      }
    }
    if (other.getType() == TYPE_BULLET) {
      return distanceTo(other) <= getSize() + other.getSize();
    }
    
    return false;
  }
  
  public int getDmg() {
    return dmg;
  }
  
}
    
    
