import ddf.minim.*;

Game game;

void setup() {
  size(600,400);
  game = new Game();
}

void draw() {
  background(0x22, 0x00, 0x11);
  game.update();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) { game.input("UP"); }
    if (keyCode == DOWN) { game.input("DOWN"); }
    if (keyCode == LEFT) { game.input("LEFT"); }
    if (keyCode == RIGHT) { game.input("RIGHT"); }
  }
}
