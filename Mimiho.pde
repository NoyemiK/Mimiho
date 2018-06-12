import ddf.minim.*;

Game game;
PFont regular_font;

void setup() {
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
  //text("FPS: " + (int) frameRate, 0, 24);
}

void keyPressed() {
  if (key == 'z') { game.input("CONFIRM"); }
  else if (key == CODED) {
    if (keyCode == UP) { game.input("UP"); }
    if (keyCode == DOWN) { game.input("DOWN"); }
    if (keyCode == LEFT) { game.input("LEFT"); }
    if (keyCode == RIGHT) { game.input("RIGHT"); }
  }
}
