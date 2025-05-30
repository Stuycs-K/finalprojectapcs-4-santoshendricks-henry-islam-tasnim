class Field {
  ArrayList<AFieldObject> objects;
  Player user;
  int fWidth; // Written this way because width and height are processing global variables
  int fHeight;
  
  public Field(int w, int h) {
    user = new Player(); // Write player constructor
    
    objects = new ArrayList<AFieldObject>();
    fWidth = w;
    fHeight = h;
  }
  
}
