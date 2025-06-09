abstract class AFieldObject {
  private PVector position;
  private PVector speed;
  private PVector direction;
  private int type;
  private int hp;
  private color objColor;
  private int size;
  private int maxHp;
  
  private int team; // this is a number that identifies an object

  private boolean isVisible;
  
  public AFieldObject(int type, int team, PVector position, PVector speed, PVector direction, int hp, color objColor, int size) {
    this.type = type;
    this.position = position;
    this.speed = speed;
    this.direction = direction;
    this.type = type;
    this.hp = hp;
    this.maxHp = hp;
    this.objColor = objColor;
    this.team = team;
    this.size = size;
  }

  public boolean isVisible() {
    return isVisible;
  }

  public abstract void render();
  public abstract void tick(Field field);
  public abstract boolean isTouching(AFieldObject other);
  
  public void tickPos(Field field) {
    PVector pos = position;
    position.add(speed);
        for (int i = 0; i < field.objects.size(); i++) {
      AFieldObject obj = field.objects.get(i);// get object from list

      if (obj.getType() == TYPE_POLY) {
        if (obj.isTouching(this)) { // isTouching autmatically applies damage, check Bullet code
          position = pos; //"kills" bullet
        }
      }
    }
    
  }
  
  public float distanceTo(AFieldObject other) {
    return PVector.sub(position, other.getPosition()).mag();
  }

  public PVector getPosition() {
    return position.copy();
  }
  public void setPosition(PVector pos) {
    position = pos;
  }
  public void addPosition(PVector change) {
    position.add(change);
  }
  
  public void setX(float x) {
    position.x = (float)x;
  }

  public void setY(float y) {
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
  public float getX() {
    return position.x;
  }

  public float getY() {
    return position.y;
  }

  public PVector getDirection() {
    return direction.copy();
  }
  public void setDirection(PVector dir) {
    direction = dir.normalize();
  }

  public int getHp() {
    return hp;
  }
  public void setHp(int hp) {
    this.hp = hp;
  }
  public int getMaxHp() {
    return maxHp;
  }
  public void setMaxHp(int maxHp) {
    this.maxHp = maxHp;
  }

  public int getType() {
    return type;
  }

  public float getSpeedMag() {
    return speed.mag();
  }
  public PVector getSpeed() {
    return speed.copy();
  }
  public void setSpeed(PVector speed) {
    this.speed = speed;
  }
  public color getColor() {
    return objColor;
  }
  public int getTeam() {
    return team;
  }
  public int getSize() {
    return size;
  }
  public void setSize(int size) {
    this.size = size;
  }
}
