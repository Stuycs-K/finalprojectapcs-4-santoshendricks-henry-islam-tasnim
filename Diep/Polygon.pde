class Polygon extends AFieldObject {
 private int type;
 private int xpStored;
 
 public Polygon(int team, PVector position, PVector speed, PVector direction, color objColor, int size,int shape, int xPt) {
   super(2, 0, position, speed, direction, 100, objColor, size);
   type = shape;
   xpStored = xPt;

   
 }
  
  public boolean isTouching(AFieldObject other) { return true;}
  
public void render() {
  fill(getColor());
  stroke(0);
  float angle = TWO_PI / 5;  
  beginShape();
  for (int i = 0; i < 5; i++) {
    float sx = getPosition().x + cos(angle * i) * getSize();
    float sy = getPosition().y + sin(angle * i) * getSize();
    vertex(sx, sy);
  }
  endShape(CLOSE);
}


}
