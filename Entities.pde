class Entity {
  int hit_points, armour_points, strength, speed;
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
  int portrait;
  
  Player() {
    
    //Setup the portrait graphics
    portrait = 6;
    portrait_strip = loadImage("graphics/amihailu_big.png");
    for(int i = 0; i < 8; i++)
      portraits[i] = portrait_strip.get(i * 48, 0, 48, 128);
  }
}
