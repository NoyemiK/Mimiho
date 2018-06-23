class GameResources {
  
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
  byte[] p_data = loadBytes("data/extconf.bun2");
  try {
    println(p_data[0] + " " + p_data[1] + " " + p_data[2] + " " + p_data[3]);
  }
  catch (Exception e) {
    println("Persistent data not found. Regenerating file...");
    generate_persistent_data();
    load_persistent_data(game);
  }
  
  for ( int i = 0; i < 6; i++ ) {
    game.persistent_data[i] = (short) (p_data[i] & 0xFF);
  }
}

void save_persistent_data(Game game) {
  byte[] p_data = new byte[6];
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
    0x00                     // Achievements. More on those later
  };
  
  saveBytes("data/extconf.bun2", p_data);
}
