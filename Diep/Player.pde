class Player extends FieldObject {
   private int xp;
   private int level;
   private int name;
   private int tankClass;
   private int teams;
   
   
   
   public int getXP(){
     return xp;
   }
   
   public int setXP(int newp){
     xp = newp;
     return xp;
   }
   public int getLevel() {
     return level;
   }
   
   public int calcLevel() {
     level = (Math.log(xp) / Math.log(2));
     return (int)level; 
   }
   
   public double distanceTo(AFieldObject other){
     return PVector.sub(this.position, other.getPosition()).mag();
   }
   public void render(){
     rect( PVector.add(position.x, norm(direction.x) * size /2),PVector.add(position.y,norm(direction.y)*size/2));
     circle(position.x,position.y);
   }
  
 
  
}
