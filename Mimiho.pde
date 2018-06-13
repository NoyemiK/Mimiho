import ddf.minim.*;

Game game;
PFont regular_font;
boolean debug_mode;

void setup() {
  debug_mode = false;
  size(640,400);
  frameRate(60);
  regular_font = loadFont("regular.vlw");
  textFont(regular_font);
  game = new Game();
  
}

void draw() {
  background(0x22, 0x22, 0x22);
  game.update();
  
  //Debug info
  if (debug_mode) {
    text("FPS: " + (int) frameRate, 0, 24);
  }
}

void keyPressed() {
  if (key == 'z') { game.input("CONFIRM"); }
  if (key == 'x') { game.input("CANCEL"); }
  if (key == 'a') { game.input("MELEE"); }
  if (key == 'a') { game.input("GUN"); }
  if (key == ESC) { key = 0; game.input("CANCEL");}
  else if (key == CODED) {
    if (keyCode == UP) { game.input("UP"); }
    if (keyCode == DOWN) { game.input("DOWN"); }
    if (keyCode == LEFT) { game.input("LEFT"); }
    if (keyCode == RIGHT) { game.input("RIGHT"); }
  }
}
