import java.util.*;

static final int PLAYER_START_SIZE = 25;
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
  
  //System.out.println(globalField.objects.size());
}


void applyCamera() {
  PVector ppos = globalField.user.getPosition();
  translate(width/2 - ppos.x, height/2 - ppos.y);
}


void draw() {
  if (!gameStarted) {
    menu.display();
  } else {
    background(225);
    
    
    // keep the guy in the center
    pushMatrix();
    applyCamera();  
    // world border
    fill(210, 210, 210);
    stroke(0);
    strokeWeight(5);
    rect(0, 0, globalField.fWidth, globalField.fHeight);
    noStroke();
    fill(180, 180, 180);
    for (int i = 20; i < globalField.fWidth; i+=20) {
      rect(-globalField.fWidth / 2 + i, 0, 1, globalField.fHeight - 5);
    }
    for (int i = 20; i < globalField.fHeight; i+=20) {
      rect(0, -globalField.fHeight / 2 + i, globalField.fWidth, 1);
    }



    for (int i = 0; i < globalField.objects.size(); i++) {
      globalField.objects.get(i).tick(globalField);
    }
    globalField.user.tick(globalField);

    for (int i = 0; i < globalField.objects.size(); i++) {
      if (globalField.objects.get(i).getHp() <= 0) {
        //globalField.remObj(globalField.objects.get(i));
        
        //i--; penta
        
        AFieldObject obj = globalField.objects.get(i);
        if (obj.getKilledByTeam() == TEAM_USER) {
          if (obj.getType() == TYPE_PLAYER) {
            globalField.user.setXP(globalField.user.getXP() + 40);
          }
          if (obj.getType() == TYPE_POLY) {
            Polygon tmp = (Polygon) obj;
          
            globalField.user.setXP(globalField.user.getXP() + tmp.getXPStored());
          }
        }
        
        if (obj.getType() == TYPE_BULLET) {
          globalField.remObj(obj);
        } else {
          globalField.objects.get(i).setPosition(new PVector((float)Math.random() * globalField.fWidth - globalField.fWidth / 2, (float)Math.random() * globalField.fHeight - globalField.fHeight / 2));
          globalField.objects.get(i).setHp(100);
        }
      } else {
        globalField.objects.get(i).render();
      }
    }
    globalField.user.render();

    popMatrix();
  }
}



void mousePressed() {
  if (!gameStarted) {
    menu.handleClick(mouseX, mouseY);
    if (menu.isStartPressed()) {
      // NOW we create the field after player typed name
      globalField = new Field(3000, 3000, menu.getPlayerName());
 // Player e0 = new Player(2, new PVector(4800, 4800), new PVector(0, 0), new PVector(0, 0), color(150, 0, 0), PLAYER_START_SIZE, "Enemy 1");
  
  //globalField.addObj(e0);
  
  for (int i = 0; i < 20; i++) {
    Player e = new Player(i + 2, new PVector((float)Math.random() * globalField.fWidth - globalField.fWidth / 2, (float)Math.random() * globalField.fHeight - globalField.fHeight / 2), new PVector(0, 0), new PVector(0, 0), color(150, 0, 0), PLAYER_START_SIZE, "Enemiesss " + (i+1));
    globalField.addObj(e);
  }
  for (int i = 0; i < 20; i++) {
    Polygon e = new Polygon(TEAM_POLY, new PVector((float)Math.random() * globalField.fWidth - globalField.fWidth / 2, (float)Math.random() * globalField.fHeight - globalField.fHeight / 2), new PVector(0, 0), new PVector(0, 0), color(150, 150, 0), PLAYER_START_SIZE/2, (int)(Math.random() * 3 + 1), 10);
    globalField.addObj(e);
  }
      gameStarted = true;
    }
  }
  if (gameStarted) globalField.mouseDown = true;
}

void mouseReleased() {
  if (globalField != null) {
    globalField.mouseDown = false;
  }
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
