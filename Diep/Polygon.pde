class Polygon extends AFieldObject {
 private int type;
 private int xpStored;
 
 public Polygon(int team, PVector position, PVector speed, PVector direction, color objColor, int size,int shape, int xPt) {
   super(2, 0, position, speed, direction, 100, objColor, size);
   type = shape;
   xpStored = xPt;

   
 }
  
  public boolean isTouching(AFieldObject other) { return true;}
  
  public void render(){}
}
