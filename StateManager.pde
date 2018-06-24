
class Game {
  
  ArrayList<GameState> gamestate_stack = new ArrayList<GameState>();
  Player player;
  short[] persistent_data = new short[6];
  
  Game () {
    player = new Player();
    gamestate_stack.add(new TitleState());
    load_persistent_data(this);
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
      case 3:
        game.push_gamestate(new DebugMenu());
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
    switch (selection_index) {
      case 0:
        game.push_gamestate(new PlayField(30, 30));
        break;
      case 1:
        game.push_gamestate(new PlayField(30, 30));
        break;
    }
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
    "Load a saved game", "Delete a saved game", "Reset persistent data", "Return to Title"
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
    switch(selection_index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        game.push_gamestate(new ConfirmDialog("FILE_PERSISTENT"));
        break;
      case 3:
        game.pop_gamestate();
        break;
    }
  }
  
  void input_cancel() {
      game.pop_gamestate();
  }
  
}

class PlayField implements GameState {
  Camera camera;
  PGraphics stat_buffer = createGraphics(188, 340);
  PGraphics tilemap_buffer = createGraphics(340, 340);
  PImage frame;
  int field_width;
  int field_height;
  int frame_corner_x = 30;
  int frame_corner_y = 30;
  int[][] map_tiles;
  
  PlayField (int fw, int fh) {
    frame = loadImage("data/graphics/frame.png");
    field_width = fw;
    field_height = fh;
    Resources.load_mapset(1);
    map_tiles = Resources.get_map(0, 30, 30);
    camera = new Camera(0, 0, 30);
    update_stat_buffer();
    update_tilemap_buffer();
  }
  
  void update() {
    int player_screen_x = frame_corner_x + ((game.player.x * 20) - (camera.x * 20));
    int player_screen_y = frame_corner_y + ((game.player.y * 20) - (camera.y * 20));
    image(frame, 0, 0);
    image(tilemap_buffer, frame_corner_x, frame_corner_y);
    image(stat_buffer, 421, 30);
    image(Resources.spriteset[game.player.sprite], player_screen_x, player_screen_y);
  }
  
  void update_stat_buffer() {
    stat_buffer.beginDraw();
    stat_buffer.textFont(regular_font);
    stat_buffer.image(game.player.playable_characters[game.player.character].portraits[game.player.portrait], 0, 0);
    stat_buffer.fill( 0xFF, 0x99, 0x99 );
    stat_buffer.text("HEALTH:\n         " + game.player.hit_points + "/" + game.player.max_hit_points, 48, 12);
    stat_buffer.text("ARMOUR:\n         " + game.player.armour_points + "/" + game.player.max_armour_points, 48, 48);
    stat_buffer.endDraw();
  }
  
  void update_tilemap_buffer() {
    tilemap_buffer.beginDraw();
    for (int h = 0; h < 17; h++) {
      for (int w = 0; w < 17; w++) {
        tilemap_buffer.image(Resources.tileset[map_tiles[w + camera.x][h + camera.y]], (w * 20), (h * 20));
      }
    }
    tilemap_buffer.endDraw();
  }
  
  void update_game_camera() {
    if (game.player.x > (camera.x + 8)) {
      camera.translate(1, 0);
      update_tilemap_buffer();
    } else if (game.player.x < (camera.x + 8)) {
      camera.translate(-1, 0);
      update_tilemap_buffer();
    }
    if (game.player.y > (camera.y + 8)) {
      camera.translate(0, 1);
      update_tilemap_buffer();
    } else if (game.player.y < (camera.y + 8)) {
      camera.translate(0, -1);
      update_tilemap_buffer();
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
      case "LEFT":
        input_left();
        break;
      case "RIGHT":
        input_right();
        break;
      case "CONFIRM":
        //input_confirm();
        break;
      case "CANCEL":
        input_cancel();
        break;
    }
    update_game_camera();
  }
  
  void input_up() {
    game.player.move(0, -1);
  }
  
  void input_down() {
    game.player.move(0, 1);
  }
  void input_left() {
    game.player.move(-1, 0);
  }
  
  void input_right() {
    game.player.move(1, 0);
  }
  void input_cancel() {
    game.pop_gamestate();
  }
}
