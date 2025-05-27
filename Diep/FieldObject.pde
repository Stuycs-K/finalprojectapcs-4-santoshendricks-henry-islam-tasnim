abstract class FieldObject {
  private double x;
  private double y;
  private double speed;
  private double direction;
  private int type;
  private int hp;
  private boolean isVisible;
  
  public boolean isVisible() {
    return isVisible;
  }
  public abstract void render();
  public abstract void isTouching(FieldObject other);
  public void rotateLeft(double degree) {
    direction += degree;
  }
  public void setX(double x) {
    this.x = x;
  }
  public void setY(double y) {
    this.y = y;
  }
  // takeDamage will return true upon death
  public boolean takeDamage(int dmg) {
    hp -= dmg;
    if (hp <= 0) {
      hp = 0;
      return true;
    }
    return false;
  }
  public void heal(int health) {
    hp += health;
  }
  
  // functions to be added to UML
  public double getX() {
    return x;
  }
  public double getY() {
    return y;
  }
  public double getDirection() {
    return direction;
  }
  public int getHp() {
    return hp;
  }
  public int getType() {
    return type;
  }
  public double getSpeed() {
    return speed;
  }
  
}
