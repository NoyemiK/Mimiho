class GameResources {
  JSONObject mapset;
  int num_maps;
  PImage tileset_img;
  PImage spriteset_img;
  PImage[] tileset = new PImage[32];
  PImage[] spriteset = new PImage[32];
  
  GameResources () {
    tileset_img = loadImage("data/graphics/tileset.png");
    spriteset_img = loadImage("data/graphics/spriteset.png");
    
    for (int h = 0; h < 4; h++) {
      for (int w = 0; w < 8; w++) {
        spriteset[(8*h) + w] = spriteset_img.get(w * 20, h * 20, 20, 20);
        tileset[(8*h) + w] = tileset_img.get(w * 20, h * 20, 20, 20);
      }
    }
  }
  
  void load_mapset(int which) {
    mapset = loadJSONObject("data/mapsets/mapset_" + which + ".json");
    switch (which) {
      case 1:
        num_maps = 10;
        break;
    }
  }
  
  int[][] get_map(int index, int mw, int mh) {
    JSONArray layers = mapset.getJSONArray("layers");
    JSONObject mapset_data = layers.getJSONObject(0);
    JSONArray mapset_tiles = mapset_data.getJSONArray("data");
    int[][] tiles = new int[mw][mh];
    
    for (int h = 0; h < mh; h++) {
      for (int w = 0; w < mw; w++) {
        int x = index % 2;
        int y = index / 2;
        int transformed = ((w + (x * mw)) + (mw * 2) * (h + (y * mw))); //Has to account for the fact that the array is two-columns
        tiles[w][h] = (mapset_tiles.getInt(transformed) - 1);
        if (tiles[w][h] == 31 || tiles[w][h] == 29) {                   //This is a dirty hack, plain and simple
          game.player.move(w, h, true);
        }
      }
    }
    return tiles;
  }
  
  boolean[][] setup_passability(int[][] map, int mw, int mh) {
    boolean[][] pass_map = new boolean[mw][mh]; //The passability matrix maps cleanly to the graphical map.
    boolean[] passkey = {                       //The key tells which tiles are passable.
      false, false, false, false, false, false, false, false,
      true, true, true, true, true, true, true, true,
      false, false, false, false, false, false, false, false,
      false, false, true, true, true, true, true, true
    };
    
    for (int h = 0; h < mh; h++) {
      for (int w = 0; w < mw; w++) {
        pass_map[w][h] = passkey[map[w][h]];
      }
    }
    return pass_map;
  }
}

class Perk {
  /*=====================================*\
  | Perk effect:                          |
  |   an 8-byte array that decodes to     |
  |   different effects on player stats.  |
  \*=====================================*/
  String name;
  String desc;
  byte[] effect = new byte[8];
  
  Perk (String n, String d, byte[] eff) {
    name = n;
    desc = d;
    effect = eff;
  }
  
}

void load_persistent_data(Game game) {
  // Generate persistent data if it's not in the directory
  byte[] p_data = loadBytes("data/extconf.bun2");
  try {
    println(p_data[0] + " " + p_data[1] + " " + p_data[2] + " " + p_data[3]);
  }
  catch (Exception e) {
    println("Persistent data not found. Regenerating file...");
    generate_persistent_data();
    load_persistent_data(game);
    return;
  }
  
  for ( int i = 0; i < p_data.length; i++ ) {
    game.persistent_data[i] = (short) (p_data[i] & 0xFF);
  }
  
  if (p_data[6] > 10){ music.mute(); }
  else { music.setGain((float) p_data[6] * -1); }
}

void save_persistent_data(Game game) {
  byte[] p_data = new byte[7];
  for ( int i = 0; i < 6; i++ ) {
    p_data[i] = (byte) game.persistent_data[i];
  }
  
  saveBytes("data/extconf2.bun2", p_data);
}

void generate_persistent_data() {
  byte[] p_data = {
    (byte) VERSION_NUM,      // Version header
    0x03, 0x03,              // Character outfit unlocks (Amihailu, Kekolu)
    0x00,                    // Token Count, element gets ANDed with 0xFF to create unsigned byte
    0x00,                    // Dungeon Count. Represents unlocked gauntlets
    0x00,                    // Achievements
    0x00                     // Music Volume
  };
  
  saveBytes("data/extconf.bun2", p_data);
}
