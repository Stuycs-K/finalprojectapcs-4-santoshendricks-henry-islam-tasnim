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

  // On Screen Checker
  boolean onScreen() {
    // tried to do a way to offset the coordinates for rotating objects so that stuff doesn't dissapear when only the center is off screen
  float screenX = pos.x - dir.x * r;
  float screenY = pos.y - dir.y * r;
  return screenX + r > Player.player.pos.x - width/2 &&
         screenX - r < Player.player.pos.x + width/2 &&
         screenY + r > Player.player.pos.y - height/2 &&
         screenY - r < Player.player.pos.y + height/2;
    // there are errors here but I want to save the player pos grab for the static player variable in the subclasses since I cant declare statics here
  }

  // subclasses self-draw if on screen to optimize running
void show() {
  if (onScreen()) {
    fill(255, 0, 0);
    ellipse(pos.x, pos.y, r * 2, r * 2);
  }
}

}
