public class Barrier extends GameObject implements Damageable{
  private static final int STARTING_HEALTH = 5;
  private static final int HITBOX_X = 150, HITBOX_Y = 40;
 
  private PImage img;
  private int health;

  public Barrier(int barrierNumber) { 
    super(barrierPositions[barrierNumber - 1][0], barrierPositions[barrierNumber - 1][1], HITBOX_X, HITBOX_Y);
    this.img = barrierNumber < 4 ? loadImage("imgs/forceFieldOne.png") : loadImage("imgs/forceFieldTwo.png");
    this.health = STARTING_HEALTH;
  }

  public GameObject drawObject() {
    imageMode(CENTER);
    image(img, posX, posY);
    fill(255);
    textSize(20);
    textAlign(CENTER);
    text(str(health), posX, posY);
    return null;
  }
  
  public int getHealth() {
    return health;
  }
  
  public void takeDamage(int dmg){
    health -= dmg;
    if(health <= 0){
      toDelete = true;
      BARRIER_BROKEN.play();
    }
  }
}
