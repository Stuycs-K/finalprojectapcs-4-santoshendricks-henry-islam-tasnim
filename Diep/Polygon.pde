class Polygon extends AFieldObject {
 private int type;
 private int xpStored;
 
 public Polygon(int shape, int xPt) {
   type = shape;
   xpStored = xPt;
 }
  
  public boolean isTouching() { return true;}
}
