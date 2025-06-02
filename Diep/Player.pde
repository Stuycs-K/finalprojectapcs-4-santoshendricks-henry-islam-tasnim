class Player extends AFieldObject {
  private int xp;
  private int level;
  private String name;
  private int tankClass;
  private int teams;
  private double cooldown;
   
  public Player(int team, PVector position, PVector speed, PVector direction, color objColor, int size, String nameP) {
    super(0, team, position, speed, direction, 100, objColor, size);
    xp = 0;
    level = 1;
    tankClass = 0;
    name = nameP;  // (or replace with String if you plan to fix name type)
    cooldown = 0.0;
  }

  public void tick(Field field) {
    // Check if hit by a bullet or polygon
    for (int i = 0; i < field.objects.size(); i++) {
      AFieldObject obj = field.objects.get(i);// get object from list

      if (obj.getType() == TYPE_BULLET && obj.getTeam() != getTeam()) {
        if (isTouching(obj)) { // isTouching autmatically applies damage, check Bullet code
          globalField.objects.get(i).takeDamage(10); //"kills" bullet
        }
      }
    }

    if (getTeam() == TEAM_USER) {
      tickUser(field);
    } else {
      tickEnemy(field);
    }
  }

  private void tickUser(Field field) {
    PVector mouseWorld = new PVector(
  mouseX - width/2 + getPosition().x,
  mouseY - height/2 + getPosition().y
);
PVector newDirection = PVector.sub(mouseWorld, getPosition());
setDirection(newDirection);

    // check keyboard WASD
    PVector newSpeed = new PVector(0.0, 0.0);
    if (field.wKey) {
      newSpeed.add(new PVector(0.0, -1.0));
    }
    if (field.aKey) {
      newSpeed.add(new PVector(-1.0, 0.0));
    }
    if (field.sKey) {
      newSpeed.add(new PVector(0.0, 1.0));
    }
    if (field.dKey) {
      newSpeed.add(new PVector(1.0, 0.0));
    }
    setSpeed(newSpeed);
    
    // Check if you should shoot
    if (field.mouseDown && cooldown <= 0.0) {
      // Substitute without special classes; call with tasnim tonight
      shoot(field);
      cooldown = 30.0;
    }

    if (cooldown > 0.0) cooldown -= 1.0;
    tickPos();

    // clamp inside world boundaries
    PVector pos = getPosition();
    pos.x = constrain(pos.x, -field.fWidth/2, field.fWidth/2);
    pos.y = constrain(pos.y, -field.fHeight/2, field.fHeight/2);

    setPosition(pos);
  }
  
  private void tickEnemy(Field field) {
  }
  
  private void shoot(Field field) {
    Bullet newBullet = new Bullet(getTeam(), getPosition(), PVector.mult(getDirection(), 10.0), getDirection(), getColor(), 20, 5);
    field.addObj(newBullet);
  }


  public int getXP() {
    return xp;
  }

  public void setXP(int newp) {
    xp = newp;
    calcLevel();
  }
  public int getLevel() {
    return level;
  }

  public int calcLevel() {
    level = (int)(Math.log(xp + 1) / Math.log(2));
    return level;
  }
  public boolean isTouching(AFieldObject other) {
    return PVector.dist(this.getPosition(), other.getPosition()) <= this.getSize() + other.getSize();
  }

  public double distanceTo(AFieldObject other) {
    return PVector.sub(this.getPosition(), other.getPosition()).mag();
  }

public void render() {
  PVector pos = getPosition();
  PVector dir = getDirection();

  // draw body first
  fill(getColor());
  noStroke();
  circle(pos.x, pos.y, getSize());

  // draw barrel
  float barrelLength = getSize() * 1.2;
  float barrelWidth = getSize() * 0.3f;

  // calculate barrel rectangle center
  float angle = atan2(dir.y, dir.x);
  
  pushMatrix();
  translate(pos.x, pos.y);
  rotate(angle);
  fill(100);
  rectMode(CENTER);
  rect(barrelLength / 2, 0, barrelLength, barrelWidth);
  popMatrix();
}
}
