abstract class FieldObject {
  PVector pos;
  PVector vel;
  float r;
  float hp;
  boolean isAlive;

  FieldObject(PVector p, PVector v, float rad, float health) {
    pos = p.copy();
    vel = v.copy();
    r = rad;
    hp = health;
    isAlive = true;
  }

  // basic movement
  void update() {
    pos.add(vel);
  }
  
  
  // object collision check
  boolean hits(FieldObject other) {
    return PVector.dist(pos, other.pos) < r + other.r;
  }

  // damage received
  void hit(float dmg) {
    hp -= dmg;
    if (hp <= 0) isAlive = false;
  }

  // all encompassing regen (can simply be unused for polygons)
  void regenl(float amt) {
    hp += amt;
  }

  // subclasses self-draw
  abstract void show();
}
