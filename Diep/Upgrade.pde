class UpgradeMenu {
  Player player;
  float x, y, w, h;
  String[] upgrades = { "Health", "Reload Speed", "Bullet Speed", "Bullet Damage", "Move Speed" };
  int buttonHeight = 50;
  int buttonSpacing = 15;

  UpgradeMenu(Player p, float x, float y, float w) {
    this.player = p;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = 80 + (buttonHeight + buttonSpacing) * upgrades.length;
  }

void display() {
  fill(240);
  stroke(0);
  strokeWeight(4);
  rect(x, y, w, h, 20);

  fill(0);
  textAlign(CENTER, CENTER);
  textSize(26);
  text("UPGRADES", w/2 - 3*x, y );

  textSize(15);
  for (int i = 0; i < upgrades.length; i++) {
    float buttonY = y + 70 + i * (buttonHeight + buttonSpacing);
    fill(255, 200, 150);
    stroke(50);
    rect(x + 15, buttonY, w - 30, buttonHeight, 12);
    fill(0);
    float textY = buttonY + buttonHeight/2 - 5;
    text((i+1) + ": " + upgrades[i] + " (" + player.upgradeLevels[i] + ")", w/2 - 3 *x, textY -y);
  }

  fill(0);
  textSize(22);
  text("Points: " + player.upgradePoints, w/2 - 3 * x, y + h - 20);
}



  void checkClick(float mx, float my) {
    for (int i = 0; i < upgrades.length; i++) {
      float buttonY = y + 60 + i * (buttonHeight + buttonSpacing);
      if (mx > x + 15 && mx < x + w - 15 && my > buttonY && my < buttonY + buttonHeight) {
        player.applyUpgrade(i + 1);
      }
    }
  }
}
