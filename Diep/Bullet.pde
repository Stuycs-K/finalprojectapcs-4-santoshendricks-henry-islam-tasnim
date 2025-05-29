class Bullet extends AFieldObject {
  private int dmg;
  
  public Bullet(int team, PVector position, PVector speed, PVector direction, color objColor, int size, int dmg) {
    super(TYPE_BULLET, team, position, speed, direction, 0, objColor, size);
    this.dmg = dmg;
  }
  
  public void render() {
    fill(getColor());
    circle(getX(), getY(), size);
  }
  
  public boolean isTouching(AFieldObject other) {
    if (other.getType() == TYPE_PLAYER) {
      return distanceTo(other) >= size + other.getSize();
    }
  
}
    
    
