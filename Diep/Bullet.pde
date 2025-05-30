class Bullet extends AFieldObject {
  private int dmg;
  
  public Bullet(int team, PVector position, PVector speed, PVector direction, color objColor, int size, int dmg) {
    super(TYPE_BULLET, team, position, speed, direction, 0, objColor, size);
    this.dmg = dmg;
  }
  
  public void render() {
    fill(getColor());
    circle((float)getX(), (float)getY(), (float)getSize());
  }
  
  public void tick() {
    position.add(speed);
    if (isVisible()) {
      render();
    }
  
  public boolean isTouching(AFieldObject other) {
    if (other.getType() == TYPE_PLAYER) {
      return distanceTo(other) <= getSize() + other.getSize();
    }
    if (other.getType() == TYPE_BULLET) {
      return distanceTo(other) <= getSize() + other.getSize();
    }
    
    return false;
  }
  
}
    
    
