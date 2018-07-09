class Entity {
  short hit_points, armour_points, strength, speed;
  short max_hit_points, max_armour_points;
  IntDict skill_table;
  int x;
  int y;
  boolean alive;
  
  Entity() {
    this.alive = true;
    this.speed = 1;
  }
  
  void kill() {
    this.alive = false;
  }
  
  void move(int xmov, int ymov, boolean passable) {
    if (passable) {
      this.x = this.x + xmov;
      this.y = this.y + ymov;
    }
  }
}

class Player extends Entity {
  byte portrait;
  int character;
  int sprite;
  PlayerCharacter[] playable_characters = { new PlayerCharacter(1), new PlayerCharacter(2) };
  
  Player() {
    
    x = 1;
    y = 1;
    portrait = 0;
    set_character(0);
  }
  
   void set_character(int selection) {
    character = selection;
    sprite = selection;
  }
  
  void init_pos() {
    this.x = 0;
    this.y = 0;
  }
  
}


//===========================
//  Additional Classes
//===========================

class PlayerCharacter {
  PImage portrait_strip;
  PImage[] portraits = new PImage[8];
  String[] outfit_names = new String[8];
  StringBuilder char_info;
  String character_name;
  
  PlayerCharacter(int choice) {
    switch (choice) {
      case 1:
        generate_amihailu();
        break;
      case 2:
        generate_kekolu();
        break;
    }
    char_info = new StringBuilder(character_name);
  }
  
   void get_info() {
    char_info.setLength(character_name.length());
    char_info.append("\nOUTFIT: ");
    char_info.append(outfit_names[game.player.portrait]);
    char_info.append("\n OUTFIT PERK: []");
  }
  
   void draw_portrait(int x, int y) {
    image(portraits[game.player.portrait], x, y);
  }
  
  private void generate_amihailu() {
    character_name = "Amihailu Dugashoba";
    portrait_strip = loadImage("graphics/amihailu_big.png");
    String[] names = {
      "Comfy Set", "Dreamland Set", "Winter Set", "Roundhouse Set",
      "Misha Bullying Set", "Dugashoba-munja Set", "Queen Saul Set", "Comfier Set"
    };
    for (int i = 0; i < 8; i++) {
      outfit_names[i] = names[i];
      portraits[i] = portrait_strip.get(i * 48, 0, 48, 128);
    }
  }
  
  private void generate_kekolu() {
    character_name = "Kekolu Chuudai";
    portrait_strip = loadImage("graphics/kekolu_big.png");
    String[] names = {
      "Sugar Bunny Set", "Sunrise Bunny Set", "Service Bunny Set", "Snowy Bunny Set",
      "Sunset Bunny Set", "Close Quarter Bunny Set", "Designated-Marksbunny Set", "Sleepy Bunny Set"
    };
    for (int i = 0; i < 8; i++) {
      outfit_names[i] = names[i];
      portraits[i] = portrait_strip.get(i * 48, 0, 48, 128);
    }
  }
}

class Camera {
  int x;
  int y;
  int max_x;
  int max_y;
  
  Camera (int init_x, int init_y, int mapsquare) {
    this.x = init_x;
    this.y = init_y;
    this.max_x = mapsquare - 17;
    this.max_y = mapsquare - 17;
  }
  
  void translate(int tx, int ty) {
    if ((x + tx < 0) || (x + tx > max_x))
      tx = 0;
    if ((y + ty < 0) || (y + ty > max_y))
      ty = 0;
    this.x += tx;
    this.y += ty;
  }
}
