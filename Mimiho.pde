import ddf.minim.*;
import com.jogamp.newt.event.KeyEvent;

Game game;
GameResources Resources;
PFont regular_font;
Minim minim;
AudioPlayer music;
boolean debug_mode;
int VERSION_NUM = 0_01;

void setup() {
  debug_mode = false;
  size(640,400);
  frameRate(60);
  regular_font = loadFont("regular.vlw");
  textFont(regular_font);
  
  minim = new Minim(this);
  music = minim.loadFile("music/GAME_1.mp3");
  game = new Game();
  Resources = new GameResources();
  
  music.loop();
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
    if (keyCode == ALT) { game.volume_down(); }
    if (keyCode == CONTROL) { game.volume_up(); }
  }
}
