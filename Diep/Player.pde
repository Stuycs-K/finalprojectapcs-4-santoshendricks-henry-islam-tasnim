class Player extends AFieldObject {
  private int xp;
  private int level;
  private String name;
  private int tankClass;
  private int teams;
  private double cooldown;
  
  private int enemyMode;
  private AFieldObject target;
  private final int ENEMY_PEACEFUL = 0;
  private final int ENEMY_STRAFE = 1;
  private final int ENEMY_CHARGE = 2;
  private final int ENEMY_RETREAT = 3;
  private final int ENEMY_BACK_UP = 4;
  private final int[] ENEMY_CHOICES = {ENEMY_STRAFE, ENEMY_CHARGE, ENEMY_RETREAT};
  private double modeCooldown;
  private double strafeCooldown;
  private boolean strafingRight;
  private final float VISION_RADIUS = 900;
  private final float MIN_FIGHTING_DIST = 200;
  private double backupDistance;
  
  // Down here are special attributes for powerups
  private float speedStat;
   
  public Player(int team, PVector position, PVector speed, PVector direction, color objColor, int size, String nameP) {
    super(0, team, position, speed, direction, 100, objColor, size);
    xp = 0;
    level = 1;
    tankClass = 0;
    name = nameP;  // (or replace with String if you plan to fix name type)
    cooldown = 0.0;
    enemyMode = ENEMY_PEACEFUL;
    target = null;
    speedStat = 5.0;
    strafeCooldown = 60.0;
    strafingRight = true;
    backupDistance = 400;
    modeCooldown = 10.0;
  }

  public void tick(Field field) {
    // Check if hit by a bullet or polygon
    for (int i = 0; i < field.objects.size(); i++) {
      AFieldObject obj = field.objects.get(i);// get object from list

      if (obj.getType() == TYPE_BULLET && obj.getTeam() != getTeam()) {
        if (obj.isTouching(this)) { // isTouching autmatically applies damage, check Bullet code
          globalField.objects.get(i).takeDamage(10); //"kills" bullet
        }
      }
    }

    if (getTeam() == TEAM_USER) {
      tickUser(field);
    } else {
      tickEnemy(field);
      //text(getHp(), 100, 100);
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
    setSpeed(newSpeed.normalize().mult(speedStat));
    
    // Check if you should shoot
    if (field.mouseDown && cooldown <= 0.0) {
      // Substitute without special classes; call with tasnim tonight
      shoot(field);
      cooldown = 30.0;
    }

    if (cooldown > 0.0) cooldown -= 1.0;
    tickPos(field);

    // clamp inside world boundaries
    PVector pos = getPosition();
    pos.x = constrain(pos.x, -field.fWidth/2, field.fWidth/2);
    pos.y = constrain(pos.y, -field.fHeight/2, field.fHeight/2);

    setPosition(pos);
    
    if (getHp() <= 0) {
      setPosition(new PVector((float)Math.random() * -field.fWidth, (float)Math.random() * -field.fHeight));
      setHp(100);
    }
  }
  
  private void tickEnemy(Field field) {
    if (enemyMode == ENEMY_PEACEFUL) {
      // Keep moving in a random direction or switch direction
      if (modeCooldown <= 0.0) {
        double angle = Math.random() * 2 * Math.PI;
        setSpeed(new PVector((float)(speedStat * Math.cos(angle)), (float)(speedStat * Math.sin(angle))));
        modeCooldown = (Math.random() * 120 + 50);
      }
      ArrayList<AFieldObject> objects = field.objects;
      ArrayList<AFieldObject> targetList = new ArrayList<AFieldObject>();
      for (int i = 0; i < objects.size(); i++) {
        if (distanceTo(objects.get(i)) <= VISION_RADIUS && objects.get(i).getType() == TYPE_PLAYER && objects.get(i).getTeam() != getTeam()) {
          // add target
          targetList.add(objects.get(i));
        }
      }
      // Player takes noa priority
      if (distanceTo(field.user) <= VISION_RADIUS) {
        
        targetList.add(field.user);
        
      }
      
      if (targetList.size() > 0) {
        target = targetList.get((int)(Math.random() * targetList.size()));
        enemyMode = ENEMY_CHOICES[(int)(Math.random() * (ENEMY_CHOICES.length - 1))];
        modeCooldown = (Math.random() * 120 + 180);
      }
      
    } else if (enemyMode == ENEMY_STRAFE) {
      if (strafingRight) { // Switching between left and right strafe
        PVector newDir = PVector.sub(target.getPosition(), getPosition());
        setDirection(newDir);
        PVector newSpeed = new PVector(getDirection().y, -getDirection().x);
        if (distanceTo(target) >= MIN_FIGHTING_DIST) {
          newSpeed.add(getDirection());
        } else {
          enemyMode = ENEMY_BACK_UP;
        }
        newSpeed.normalize().mult(speedStat);
        setSpeed(newSpeed);
        
        strafeCooldown -= 1.0;
        if (strafeCooldown <= 0.0) {
          strafingRight = false; //Flip strafe direction
          strafeCooldown = 60.0;
        }
      } else {
        PVector newDir = PVector.sub(target.getPosition(), getPosition());
        setDirection(newDir);
        PVector newSpeed = new PVector(-getDirection().y, getDirection().x);
        if (distanceTo(target) >= MIN_FIGHTING_DIST) {
          newSpeed.add(getDirection());
        } else {
          enemyMode = ENEMY_BACK_UP;
        }
        newSpeed.normalize().mult(speedStat);
        setSpeed(newSpeed);
        
        strafeCooldown -= 1.0;
        if (strafeCooldown <= 0.0) {
          strafingRight = true;
          strafeCooldown = 60.0;
        }
      }
      // Shoot!
      if(cooldown <= 0.0) {
        shoot(field);
        cooldown = 30.0;
      }
      
      if (modeCooldown <= 0.0) {
        enemyMode = ENEMY_CHOICES[(int)(Math.random() * (ENEMY_CHOICES.length - 1))];
        modeCooldown = (Math.random() * 120 + 180);
      }
      
    } else if (enemyMode == ENEMY_CHARGE) {
      PVector newDir = PVector.sub(target.getPosition(), getPosition());
      setDirection(newDir);
      PVector newSpeed = PVector.mult(getDirection(), speedStat);
      setSpeed(newSpeed);
      
      //Shoot!
      if(cooldown <= 0.0) {
        shoot(field);
        cooldown = 30.0;
      }
      
      if (modeCooldown <= 0.0) {
        enemyMode = ENEMY_CHOICES[(int)(Math.random() * (ENEMY_CHOICES.length - 1))];
        modeCooldown = (Math.random() * 120 + 180);
      }
      if (distanceTo(target) <= MIN_FIGHTING_DIST) {
          enemyMode = ENEMY_BACK_UP;
      }
    } else if (enemyMode == ENEMY_BACK_UP) {
      if (distanceTo(target) <= backupDistance) {
        PVector newDir = PVector.sub(target.getPosition(), getPosition());
        setDirection(newDir);
        PVector newSpeed = PVector.mult(getDirection(), -speedStat);
        setSpeed(newSpeed);
      } else {
        enemyMode = ENEMY_CHOICES[(int)(Math.random() * (ENEMY_CHOICES.length - 1))];
        modeCooldown = (Math.random() * 120 + 180);
        backupDistance = (Math.random() * 300 + 300);
      }
      if(cooldown <= 0.0) {
        shoot(field);
        cooldown = 30.0;
      }
      
    }
      
      
      
    
    tickPos(field);
        // clamp inside world boundaries
    PVector pos = getPosition();
    pos.x = constrain(pos.x, -field.fWidth/2, field.fWidth/2);
    pos.y = constrain(pos.y, -field.fHeight/2, field.fHeight/2);

    setPosition(pos);
    
    if (modeCooldown > 0.0) {
      modeCooldown -= 1.0;
    }
    if (getTeam() == 3)System.out.println(modeCooldown);
    if (cooldown > 0.0) cooldown -= 1.0;
    if (target == null || target.getHp() <= 0 || distanceTo(target) > VISION_RADIUS) {
      enemyMode = ENEMY_PEACEFUL;
    }
  }
  
  private void shoot(Field field) {
    Bullet newBullet = new Bullet(getTeam(), getPosition(), PVector.mult(getDirection(), 10.0), getDirection(), getColor(), 20, 10, 120.0);
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
    return PVector.dist(this.getPosition(), other.getPosition()) <= (this.getSize() + other.getSize());
  }

  public float distanceTo(AFieldObject other) {
    return PVector.sub(this.getPosition(), other.getPosition()).mag();
  }

public void render() {
  PVector pos = getPosition();
  PVector dir = getDirection();

  // draw body first
  fill(getColor());
  noStroke();
  circle(pos.x, pos.y, getSize() *2);

  // draw barrel
  float barrelLength = getSize() * 2.4;
  float barrelWidth = getSize() * 0.6f;

  // calculate barrel rectangle center
  float angle = atan2(dir.y, dir.x);
  
  pushMatrix();
  translate(pos.x, pos.y);
  rotate(angle);
  fill(100);
  rectMode(CENTER);
  rect(barrelLength / 2, 0, barrelLength, barrelWidth);
  popMatrix();
  
  text(name + ": " + getHp(), (float)getX(), (float)getY() - getSize() - 15);
  if (getHp() > getMaxHp() * 0.75) {
    fill(0, 200, 0);
  } else if (getHp() > getMaxHp() * 0.5) {
    fill(200, 200, 0);
  } else if (getHp() > getMaxHp() * 0.25) {
    fill(200, 100, 0);
  } else {
    fill(200, 0, 0);
  }
  rectMode(CORNER);
  fill(100, 100, 100);
  rect(getX() - getSize(), getY() + getSize() + 10, 2 * getSize(), 13);
  if (getHp() > getMaxHp() * 0.75) {
    fill(0, 200, 0);
  } else if (getHp() > getMaxHp() * 0.5) {
    fill(200, 200, 0);
  } else if (getHp() > getMaxHp() * 0.25) {
    fill(200, 100, 0);
  } else {
    fill(200, 0, 0);
  }
  rect(getX() - getSize(), getY() + getSize() + 10, 2 * getSize() * ((float)getHp() / getMaxHp()), 13);
  rectMode(CENTER);
}
}
