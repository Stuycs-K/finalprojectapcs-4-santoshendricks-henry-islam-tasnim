class MainMenu {
  private String playerName;
  private PVector buttonPos;
  private float buttonWidth;
  private float buttonHeight;
  private boolean startClicked;
  private boolean nameActive;

  public MainMenu() {
    playerName = "";
    startClicked = false;
    buttonWidth = width * 0.2;
    buttonHeight = height * 0.1;  
    buttonPos = new PVector(width / 2 - buttonWidth / 2, height / 2);
    nameActive = false;
  }

  public void display() {
    background(220);

    textAlign(CENTER, CENTER);
    textSize(height * 0.04);
    fill(0);
    text("Enter Your Name", width / 2, buttonPos.y - buttonHeight - height * 0.1);

    float nameBoxWidth = width * 0.3;
    float nameBoxHeight = height * 0.06;
    float nameBoxX = width / 2 - nameBoxWidth / 2;
    float nameBoxY = buttonPos.y - buttonHeight - height * 0.08;

    stroke(0);
    fill(nameActive ? 255 : 240);
    rect(nameBoxX, nameBoxY, nameBoxWidth, nameBoxHeight, 5);

    fill(0);
    textAlign(LEFT, CENTER);
    textSize(height * 0.03);
    text(playerName, nameBoxX + 10, nameBoxY + nameBoxHeight / 2);

    fill(180);
    rect(buttonPos.x, buttonPos.y, buttonWidth, buttonHeight, 5);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(height * 0.04);
    text("START", buttonPos.x + buttonWidth / 2, buttonPos.y + buttonHeight / 2);
  }

  public void handleClick(float mx, float my) {
    float nameBoxWidth = width * 0.3;
    float nameBoxHeight = height * 0.06;
    float nameBoxX = width / 2 - nameBoxWidth / 2;
    float nameBoxY = buttonPos.y - buttonHeight - height * 0.08;

    if (mx > nameBoxX && mx < nameBoxX + nameBoxWidth && my > nameBoxY && my < nameBoxY + nameBoxHeight) {
      nameActive = true;
    } else {
      nameActive = false;
    }

    if (mx > buttonPos.x && mx < buttonPos.x + buttonWidth && my > buttonPos.y && my < buttonPos.y + buttonHeight) {
      startClicked = true;
    }
  }

  public boolean isStartPressed() {
    return startClicked;
  }

  public String getPlayerName() {
    return playerName;
  }

  public void keyInput(char key) {
    if (nameActive) {
      if (key == BACKSPACE && playerName.length() > 0) {
        playerName = playerName.substring(0, playerName.length() - 1);
      } else if (key != CODED && key != ENTER && playerName.length() < 20) {
        playerName += key;
      }
    }
  }
}
