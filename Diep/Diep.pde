import java.util.*;

static final int PLAYER_START_SIZE = 100;

static final int TYPE_PLAYER = 0;
static final int TYPE_BULLET = 1;
static final int TYPE_POLY = 2;
MainMenu menu;
Field globalField = new Field(10000, 10000);
static final int TEAM_POLY = 0;
static final int TEAM_USER = 1;

boolean gameStarted = false;

void setup() {
  size(1200, 900);
  
  Bullet t0 = new Bullet(2, new PVector(50, 50), new PVector(0,0), new PVector(0,0), color(200, 0, 0), 5, 0);
  Bullet t1 = new Bullet(2, new PVector(10.5, 0), new PVector(0,0), new PVector(0,0), color(0), 5, 0);
  System.out.println(t0.distanceTo(t1));
  System.out.println(t0.isTouching(t1));
  
  t0.render();
  
  menu = new MainMenu();
  
}

void draw() {
  if (!gameStarted) {
    menu.display();
  } else {
    background(225);
    // this is where the game will forever run through ticks
    for (AFieldObject obj : globalField.objects) {
      obj.tick(globalField);
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
