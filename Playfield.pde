class PlayField implements GameState {
  Camera camera;
  PGraphics stat_buffer = createGraphics(188, 340);
  PGraphics tilemap_buffer = createGraphics(340, 340);
  PImage frame;
  int curr_map = 0;
  int field_width;
  int field_height;
  int frame_corner_x = 30;
  int frame_corner_y = 30;
  int[][] map_tiles;
  boolean[][] passabilities;
  
  PlayField (int fw, int fh) {
    frame = loadImage("data/graphics/frame.png");
    game.player.init_pos();
    game.player.init_stats();
    field_width = fw;
    field_height = fh;
    Resources.load_mapset(1);
    map_tiles = Resources.get_map(curr_map, fw, fh);
    passabilities = Resources.setup_passability( map_tiles, fw, fh);
    camera = new Camera(0, 0, 30);
    init_game_camera();
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
    String name = game.player.playable_characters[game.player.character].character_name;
    stat_buffer.beginDraw();
    stat_buffer.textFont(regular_font);
    stat_buffer.image(game.player.playable_characters[game.player.character].portraits[game.player.portrait], 0, 0);
    stat_buffer.fill( 0xFF, 0x99, 0x99 );
    
    // For whatever reason, if I don't have a newline for this next line in particular,
    // the text renders some characters vertically stretched—very bizarre!
    stat_buffer.text("\n" + name, 48, 0);
    stat_buffer.text("HEALTH:\n         " + game.player.hit_points + "/" + game.player.max_hit_points, 48, 32);
    stat_buffer.text("ARMOUR:\n         " + game.player.armour_points + "/" + game.player.max_armour_points, 48, 64);
    stat_buffer.text("ATTACK RATING:\nDir: " + game.player.strength + "/Rng: 0", 48, 96);
    stat_buffer.text("\nMOVES PER TURN:\n         " + game.player.speed, 8, 128);
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
  
  void init_game_camera() {
    for (int i = 0; i < 16; i++)
      update_game_camera();
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
    if (map_tiles[game.player.x][game.player.y] == 28 || map_tiles[game.player.x][game.player.y] == 30) {
      change_maps(1);
    }
    else if (map_tiles[game.player.x][game.player.y] == 29 || map_tiles[game.player.x][game.player.y] == 31) {
      change_maps(-1);
    }
  }
  
  void change_maps(int dir) {
    curr_map += dir;
    if (curr_map > 7) {
      curr_map = 0;
    }
    else if (curr_map < 0) {
      curr_map = 0;
      return;
    }
    map_tiles = Resources.get_map(curr_map, field_width, field_height);
    if (dir == -1) {
      move_to_exit();
    }
    passabilities = Resources.setup_passability( map_tiles, field_width, field_height);
    init_game_camera();
    Resources.change_music(dir, curr_map);
    return;
  }
  
  void move_to_exit() {
    for (int h = 0; h < field_height; h++) {
      for (int w = 0; w < field_width; w++) {
        if (map_tiles[w][h] == 28 || map_tiles[w][h] == 30) {
          game.player.x = w;
          game.player.y = h;
        }
      }
    }
  }
  
  void input_up() {
    game.player.move(0, -1, passabilities[game.player.x][game.player.y - 1]);
  }
  
  void input_down() {
    game.player.move(0, 1, passabilities[game.player.x][game.player.y + 1]);
  }
  void input_left() {
    game.player.move(-1, 0, passabilities[game.player.x - 1][game.player.y]);
  }
  
  void input_right() {
    game.player.move(1, 0, passabilities[game.player.x + 1][game.player.y]);
  }
  void input_cancel() {
    game.pop_gamestate();
  }
}
