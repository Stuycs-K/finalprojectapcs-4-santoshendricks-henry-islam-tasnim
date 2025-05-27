class Bullet extends FieldObject {
  private int size;
  private int dmg;
  
  public Bullet(){}
  
  public void render() {
    fill(getColor());
    circle(getX(), getY(), size);
  }
  
}
    
    
