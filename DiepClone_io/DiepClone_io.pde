abstract class FieldObject {
  PVector pos;
  PVector vel;
  PVector dir;
  float r;
  float hp;
  boolean isAlive;

  FieldObject(PVector p, PVector v, PVector d, float rad, float health) {
    pos = p.copy();
    vel = v.copy();
    dir = d.copy();
    r = rad;
    hp = health;
    isAlive = true;
  }

  // basic movement
  void update() {
    pos.add(vel);
  }

  // face a direction
  void face(PVector target) {
    dir = PVector.sub(target, pos);
    dir.normalize();
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
