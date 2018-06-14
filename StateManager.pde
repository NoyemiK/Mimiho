
class Game {
  
  ArrayList<GameState> gamestate_stack = new ArrayList<GameState>();
  Player player;
  
  Game () {
    player = new Player();
    gamestate_stack.add(new TitleState());
  }
  
  void update() {
    GameState current_state = gamestate_stack.get(gamestate_stack.size() - 1);
    current_state.update();
  }
  
  void input(String signal) {
    GameState current_state = gamestate_stack.get(gamestate_stack.size() - 1);
    current_state.input(signal);
  }
  
  void push_gamestate(GameState state) {
    gamestate_stack.add(state);
    System.gc();
  }
  
  void pop_gamestate() {
    gamestate_stack.remove(gamestate_stack.size() - 1);
  }
  
  void draw_options(String[] options, int selection_index, int x, int y) {
    for ( int i = 0; i < options.length ; i++ ) {
      if (i == selection_index) { fill( 0xCC, 0x33, 0x55 ); }
      text(options[i], x, y + (i * 16));
      fill( 0xFF, 0xFF, 0xFF );
    }
  }
}

interface GameState {
  
  void update();
  void input(String signal);
  
}

//========================
// STATE LOGIC
//========================

class TitleState implements GameState {
   int selection_index;
   String[] options = { 
    "New Game", "File Menu", "Exit" 
  };
  private PImage title_card;
  
  TitleState() {
    selection_index = 0;
    title_card = loadImage("graphics/title_card.png");
    if (debug_mode) {
      options = append(options, "\n\n--DEBUG MENU--");
    }
  }
  
  void update() {
    image(title_card, 0, 0);
    game.draw_options(options, selection_index, (width/2) - 120, (height/2) + 48);
  }
  
  void input(String signal) {
    switch (signal) {
      case "UP":
        input_up();
        break;
      case "DOWN":
        input_down();
        break;
      case "CONFIRM":
        input_confirm();
        break;
    }
  }
  
  void input_up() {
    if (selection_index == 0) { selection_index = options.length - 1; }
    else { selection_index--; }
  }
  
  void input_down() {
    if (selection_index == options.length - 1) { selection_index = 0; }
    else { selection_index++; }
  }
  
  void input_left() {}
  void input_right() {}
  void input_confirm() {
    switch (selection_index) {
      case 0:
        game.push_gamestate(new NewGameState());
        break;
      case 1:
        game.push_gamestate(new FileMenu());
        break;
      case 2:
        exit();
        break;
    }
  }
  
}

class NewGameState implements GameState {
  byte selection_index;
  String[] options = { 
    "Start Game as Amihailu", "Start Game as Kekolu",
    "Option: Pimiko Mode | Level up thru Lumpee's Magic Shop        | ",
    "Option: Mimi's Ward | Disable Hunter-type AI package           | ",
    "Option: Magazines   | Weapons require reloading (1 Turn Point) | " 
  };
  char[] game_options = { 'N', 'N', 'N' };
  String char_info;
    
    NewGameState () {
      selection_index = 0;
    }
    
    void init() {
      game.player.playable_characters[game.player.character].get_info();
    }
    
    void end() {
      
    }
    
    void update() {
      game.draw_options(options, selection_index, 12, 32);
      for ( int i = 2; i < options.length; i++ ) {
        if (i == selection_index) { fill( 0xCC, 0x33, 0x55 ); }
        text(game_options[i - 2], 532, 32 + (i * 16));
        fill( 0xFF, 0xFF, 0xFF );
      }
      game.player.playable_characters[game.player.character].draw_portrait(24, 128);
      text(game.player.playable_characters[game.player.character].char_info.toString(), 16, 284);
    }
    
    void input(String signal) {
    switch (signal) {
      case "UP":
        input_up();
        break;
      case "DOWN":
        input_down();
        break;
      case "LEFT":
        input_left();
        break;
      case "RIGHT":
        input_right();
        break;
      case "CONFIRM":
        input_confirm();
        break;
      case "CANCEL":
        input_cancel();
        break;
    }
  }
  
  void input_up() {
    if (selection_index == 0) { selection_index = byte(options.length - 1); }
    else { selection_index--; }
    char_toggle();
  }
  
  void input_down() {
    if (selection_index == (options.length - 1)) { selection_index = 0; }
    else { selection_index++; }
    char_toggle();
  }
  
  void input_left() {
    if (selection_index < 2) {
      if (game.player.portrait == 0) { game.player.portrait = 7; }
      else { game.player.portrait--; }
    }
    char_toggle();
  }
  void input_right() {
    if (selection_index < 2) {
      if (game.player.portrait == 7) { game.player.portrait = 0; }
      else { game.player.portrait++; }
    }
    char_toggle();
  }
  void input_confirm() {
    
  }
  
  void input_cancel() { 
    game.pop_gamestate();
  }
  
  void char_toggle() {
    if (selection_index < 2) {
      game.player.set_character(selection_index);
      game.player.playable_characters[game.player.character].get_info();
    }
  }
}

class FileMenu implements GameState {
  int selection_index = 0;
  String[] options = {
    "Load a saved game", "Delete a saved game", "Reset persistent data"
  };
  
  FileMenu () {
    
  }
  
  void update(){
    game.draw_options(options, selection_index, width/2 - 128, 128);
  }
  
  void input(String signal) {
    switch(signal) {
      case "UP":
        input_up();
        break;
      case "DOWN":
        input_down();
        break;
      case "CONFIRM":
        input_confirm();
        break;
      case "CANCEL":
        input_cancel();
        break;
    } 
  }
  
  void input_up() {
    if (selection_index == 0) { selection_index = options.length - 1; }
    else { selection_index--; }
  }
  
  void input_down() {
    if (selection_index == options.length - 1) { selection_index = 0; }
    else { selection_index++; }
  }
  
  void input_confirm() {
    
  }
  void input_cancel() {
      game.pop_gamestate();
    }
  
}
