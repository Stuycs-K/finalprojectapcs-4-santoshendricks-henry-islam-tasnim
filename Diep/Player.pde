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
   
   public void render(){
     circle(position.x,position.y);
   }
  
 
  
}
