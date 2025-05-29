static final int TYPE_PLAYER = 0;
static final int TYPE_BULLET = 1;
static final int TYPE_POLY = 2;

static final int TEAM_POLY = 0;
static final int TEAM_USER = 1;

void setup() {
  size(1200, 900);
  
  Bullet t0 = new Bullet(2, new PVector(50, 50), new PVector(0,0), new PVector(0,0), color(200, 0, 0), 5, 0);
  Bullet t1 = new Bullet(2, new PVector(10.5, 0), new PVector(0,0), new PVector(0,0), color(0), 5, 0);
  System.out.println(t0.distanceTo(t1));
  System.out.println(t0.isTouching(t1));
  
  t0.render();
  
}
