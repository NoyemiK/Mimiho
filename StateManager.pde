public enum GameStates{
  TITLE,
  NEW_GAME,
  FILE,
  MAIN,
  SHOP,
  QUIT
}

class Game {
  
  GameStates current_state;
  TitleState title_screen;
  NewGameState new_game_screen;
  Player player;
  
  Game () {
    current_state = GameStates.TITLE;
    player = new Player();
    title_screen = new TitleState();
    new_game_screen = new NewGameState();
  }
  
  void update() {
    switch (current_state) {
      case TITLE:
        title_screen.update();
        break;
      case NEW_GAME:
        new_game_screen.update();
        break;
      case QUIT:
        exit();
        break;
    }
  }
  
  void input(String signal) {
    switch (current_state) {
      case TITLE:
        title_screen.input(signal);
        break;
      case NEW_GAME:
        new_game_screen.input(signal);
        break;
    }
  }
  
  void refresh_player() {
    player = null;
    player = new Player();
  }
}

abstract class GameState {
  
  abstract void init();
  abstract void end();
  abstract void update();
  abstract void input(String signal);
  
}

//========================
// STATE LOGIC
//========================

class TitleState extends GameState {
  public int selection_index;
  public String[] options = { "New Game", "Load Game", "Exit" };
  private PImage title_card;
  
  TitleState() {
    selection_index = 0;
    title_card = loadImage("graphics/title_card.png");
  }
  
  void init() {
    
  }
  
  void end() {
    
  }
  
  void update() {
    image(title_card, 0, 0);
    for ( int i = 0; i < options.length; i++ ) {
      if (i == selection_index) { fill( 0xCC, 0x33, 0x55 ); }
      text(options[i], width/2 - 120, (height/2 - 48) + (i * 16));
      fill( 0xFF, 0xFF, 0xFF );
    }
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
      case "CANCEL":
        input_cancel();
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
  void input_confirm() {
    game.new_game_screen.char_info = game.player.get_info();
    GameStates[] n = { GameStates.NEW_GAME, GameStates.FILE, GameStates.QUIT };
    game.current_state = n[selection_index];
  }
  void input_cancel() { init(); }
  
}

class NewGameState extends GameState {
  public int selection_index;
  public String[] options = { "Start Game as Amihailu", "Start Game as Kekolu",
    "Option: Pimiko Mode | Increase attributes at Lumpee's shop     | ",
    "Option: Mimi's Ward | Disable Hunter-type AI package           | ",
    "Option: Magazines   | Weapons require reloading (1 Turn Point) | " };
  public char[] game_options = { 'N', 'N', 'N' };
  String char_info;
    
    NewGameState () {
      selection_index = 0;
    }
    
    void init() {
      
    }
    
    void end() {
      
    }
    
    void update() {
      for ( int i = 0; i < options.length; i++ ) {
        if (i == selection_index) { fill( 0xCC, 0x33, 0x55 ); }
          if (i > 1) {
            text(game_options[i - 2], 532, 32 + (i * 16));
          }
        text(options[i], 12, 32 + (i * 16));
        fill( 0xFF, 0xFF, 0xFF );
      }
      image(game.player.portraits[game.player.portrait], 24, 128);
      text(char_info, 16, 284);
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
    if (selection_index == 0) { selection_index = options.length - 1; }
    else { selection_index--; }
    char_toggle();
  }
  
  void input_down() {
    if (selection_index == options.length - 1) { selection_index = 0; }
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
  void char_toggle() {
    if (selection_index < 2) {
      game.player.set_character(selection_index);
      char_info = new String(game.player.get_info());
    }
  }
  void input_cancel() { 
    game.current_state = GameStates.TITLE;
    game.title_screen.init();
    game.new_game_screen = null;
    game.new_game_screen = new NewGameState();
  }
}
