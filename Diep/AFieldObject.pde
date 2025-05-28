abstract class FieldObject {
  private PVector position;
  private PVector speed;
  private PVector direction;
  private int type;
  private int hp;

  private boolean isVisible;
  
  public FieldObject(int type, PVector position, PVector speed, PVector direction, int hp) {
    this.type = type;
    this.position = position;
    this.speed = speed;
    this.direction = direction;
    this.type = type;
    this.hp = hp;
  }

  public boolean isVisible() {
    return isVisible;
  }

  public abstract void render();
  public abstract void isTouching(FieldObject other);

  public void setX(double x) {
    position.x = (float)x;
  }

  public void setY(double y) {
    position.y = (float)y;
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
    return position.x;
  }

  public double getY() {
    return position.y;
  }

  public PVector getDirection() {
    return direction.copy();
  }

  public int getHp() {
    return hp;
  }

  public int getType() {
    return type;
  }

  public double getSpeed() {
    return speed.mag();
  }
}
