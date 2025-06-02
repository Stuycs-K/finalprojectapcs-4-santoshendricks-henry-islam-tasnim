import java.util.*;

static final int PLAYER_START_SIZE = 50;

static final int TYPE_PLAYER = 0;
static final int TYPE_BULLET = 1;
static final int TYPE_POLY = 2;
MainMenu menu;
Field globalField;
static final int TEAM_POLY = 0;
static final int TEAM_USER = 1;

boolean gameStarted = false;

void setup() {
  size(1200, 900);
  menu = new MainMenu();
  globalField = new Field(10000, 10000);
  Player e0 = new Player(2, new PVector(1000, 700), new PVector(0, 0), new PVector(0, 0), color(150, 0, 0), PLAYER_START_SIZE, "Enemy 1");
  globalField.addObj(e0);
}

void draw() {
  if (!gameStarted) {
    menu.display();
  } else {
    background(225);
    // this is where the game will forever run through ticks
    for (int i = 0; i < globalField.objects.size(); i++) {
      globalField.objects.get(i).tick(globalField);
    }
    globalField.user.tick(globalField);
    for (int i = 0; i < globalField.objects.size(); i++) {
      if (globalField.objects.get(i).getHp() <= 0) {
        globalField.remObj(globalField.objects.get(i));
        i--;
      } else {
        globalField.objects.get(i).render();
      }
    }
    globalField.user.render();
    
  }
}



void mousePressed() {
  if (!gameStarted) {
    menu.handleClick(mouseX, mouseY);
    if (menu.isStartPressed()) {
      gameStarted = true;
    }
  }
  globalField.mouseDown = true;
}

void mouseReleased() {
  globalField.mouseDown = false;
}

void keyPressed() {
  if (!gameStarted) {
    menu.keyInput(key);
  } else {
    if (key == 'w') {
      globalField.wKey = true;
    } else if (key == 'a') {
      globalField.aKey = true;
    } else if (key == 's') {
      globalField.sKey = true;
    } else if (key == 'd') {
      globalField.dKey = true;
    }
  }
}

void keyReleased() {
  if (gameStarted) {
    if (key == 'w') {
      globalField.wKey = false;
    } else if (key == 'a') {
      globalField.aKey = false;
    } else if (key == 's') {
      globalField.sKey = false;
    } else if (key == 'd') {
      globalField.dKey = false;
    }
  }
}
