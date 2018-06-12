class Entity {
  int hit_points, armour_points, strength, speed;
  int max_hit_points, max_armour_points;
  IntDict skill_table;
  boolean alive;
  
  Entity() {
    this.alive = true;
    this.speed = 1;
  }
  
  public void kill() {
    this.alive = false;
  }
  
  public void move() {
     
  }
}

class Player extends Entity {
  int portrait;
  int character;
  PlayerCharacter[] playable_characters = { new PlayerCharacter(1), new PlayerCharacter(2) };
  
  Player() {
    
    //Setup the portrait graphics
    portrait = 0;
    set_character(0);
  }
  
  public void set_character(int selection) {
    character = selection;
  }
  
}

class PlayerCharacter {
  PImage portrait_strip;
  PImage[] portraits = new PImage[8];
  String[] outfit_names = new String[8];
  String char_info;
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
    print(character_name);
  }
  
  public String get_info() {
    String info;
    info = new String( character_name + "\nOUTFIT: " + outfit_names[game.player.portrait] + "\nOUTFIT PERK: [" + "]\n");
    
    return info;
  }
  
  public void draw_portrait(int x, int y) {
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
      "Clear Diamond Set", "Pink Diamond Set", "Showgirl-Bunny Set", "Snowy Bunny Set",
      "Sunset Bunny Set", "Close Quarter Bunny Set", "Designated-Marksbunny Set", "Sleepy Bunny Set"
    };
    for (int i = 0; i < 8; i++) {
      outfit_names[i] = names[i];
      portraits[i] = portrait_strip.get(i * 48, 0, 48, 128);
    }
  }
}
