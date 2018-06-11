public enum GameStates{
  TITLE,
  MAIN,
  SHOP
}

class Game {
  
  GameStates current_state;
  TitleState title_screen;
  Player player;
  
  Game () {
    current_state = GameStates.TITLE;
    title_screen = new TitleState();
    player = new Player();
  }
  
  void update() {
    switch (current_state) {
      case TITLE:
        title_screen.update();
        image(player.portraits[title_screen.selection_index], 0, 0);
        break;
    }
  }
  
  void input(String signal) {
    switch (current_state) {
      case TITLE:
        title_screen.input(signal);
        break;
    }
  }
}

abstract class GameState {
  
  abstract void init();
  abstract void end();
  abstract void update();
  abstract void input(String signal);
  
}

class TitleState extends GameState {
  public int selection_index;
  
  TitleState() {
    selection_index = 0;
  }
  
  void init() {
    
  }
  
  void end() {
    
  }
  
  void update() {
    
  }
  
  void input(String signal) {
    switch (signal) {
      case "UP":
        input_up();
        break;
      case "DOWN":
        input_down();
        break;
    }
  }
  
  void input_up() {
    if (selection_index == 0) { selection_index = 2; }
    else { selection_index--; }
  }
  
  void input_down() {
    if (selection_index == 2) { selection_index = 0; }
    else { selection_index++; }
  }
  
  void input_left() {}
  void input_right() {}
  void input_confirm() {}
  void input_cancel() {}
  
}
