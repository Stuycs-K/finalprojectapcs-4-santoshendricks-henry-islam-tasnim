class Field {
  ArrayList<AFieldObject> objects;
  Player user;
  int fWidth; // Written this way because width and height are processing global variables
  int fHeight;
  
  public Field(int w, int h) {
    user = new Player(TEAM_USER, new PVector(0, 0), new PVector(0, 0), new PVector(0, 1), color(0, 0, 100), PLAYER_START_SIZE); // Write player constructor
    
    objects = new ArrayList<AFieldObject>();
    fWidth = w;
    fHeight = h;
  }
  public void addObj(AFieldObject obj) {
    objects.add(obj);
  }
  public boolean remObj(AFieldObject obj) {
    return objects.remove(obj);
  }
}
