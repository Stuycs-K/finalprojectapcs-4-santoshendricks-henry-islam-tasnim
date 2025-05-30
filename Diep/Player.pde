class Player extends AFieldObject{
   private int xp;
   private int level;
   private String name;
   private int tankClass;
   private boolean isEnemy;
   
public Player(int team, PVector position, PVector speed, PVector direction, color objColor, int size, String nameP) {
  super(0, team, position, speed, direction, 100, objColor, size);
  xp = 0;
  level = 1;
  tankClass = 0;
  name = nameP;  // (or replace with String if you plan to fix name type)
}

   
   public int getXP(){
     return xp;
   }
   
   public void setXP(int newp){
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
  rect(getPosition().x + getDirection().x * getSize() / 2,getPosition().y + getDirection().y * getSize() / 2,getSize(),getSize());

  circle(getPosition().x, getPosition().y, getSize());
}
  
 
  
}
