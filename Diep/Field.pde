class Field {
  ArrayList<AFieldObject> objects;
  Player user;
  int fWidth; // Written this way because width and height are processing global variables
  int fHeight;
  boolean wKey;
  boolean aKey;
  boolean sKey;
  boolean dKey;
  boolean mouseDown;
  
  public Field(int w, int h) {
    user = new Player(TEAM_USER, new PVector(w/2, h/2), new PVector(0, 0), new PVector(0, 1), color(0, 0, 100), PLAYER_START_SIZE, "");
    objects = new ArrayList<AFieldObject>();
    fWidth = w;
    fHeight = h;
    wKey = false;
    aKey = false;
    sKey = false;
    dKey = false;
    mouseDown = false;
  }
  public void addObj(AFieldObject obj) {
    objects.add(obj);
  }
  public boolean remObj(AFieldObject obj) {
    return objects.remove(obj);
  }
  
}
