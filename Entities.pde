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
  PImage portrait_strip;
  PImage[] portraits = new PImage[8];
  String[] amihailu_outfit_names = {
    "Comfy Set", "Dreamland Set", "Winter Set", "Roundhouse Set",
    "Misha Bullying Set", "Dugashoba-munja Set", "Queen Saul Set", "Comfier Set"
  };
  String[] kekolu_outfit_names = {
    "Clear Diamond Set", "Pink Diamond Set", "Showgirl-Bunny Set", "Snowy Bunny Set",
    "Sunset Bunny Set", "Close Quarter Bunny Set", "Designated-Marksbunny Set", "Sleepy Bunny Set"
  };
  int portrait;
  int character;
  
  Player() {
    
    //Setup the portrait graphics
    portrait = 0;
    portrait_strip = loadImage("graphics/amihailu_big.png");
    set_character(0);
  }
  
  public void set_character(int selection) {
    if (selection != 0) {
      character = 1;
      portrait_strip = loadImage("graphics/kekolu_big.png");
      set_portrait();
    }
    else {
      character = 0;
      portrait_strip = loadImage("graphics/amihailu_big.png");
      set_portrait();
    }
  }
  
  private void set_portrait() {
    for(int i = 0; i < 8; i++) {
      portraits[i] = portrait_strip.get(i * 48, 0, 48, 128);
    } 
  }
  
  public String get_info() {
    String info;
    if (character == 0) {
      info = "Amihailu Dugashoba\nOUTFIT: " + amihailu_outfit_names[portrait] + "\nOUTFIT PERK: [" + "]\n";
    }
    else {
      info = "Kekolu Chuudai\nOUTFIT: " + kekolu_outfit_names[portrait] + "\nOUTFIT PERK: [" +  "]\n";
    }
    
    return info;
  }
}
