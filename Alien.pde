public class Alien extends Ship implements Damageable{
  private static final int HITBOX = 50;
  private static final int MOVEMENT_SPEED = 1;
  private static final int HEALTH = 1;
  private static final int SHOT_VELOCITY = 8;
  private float[] FIRE_RATE_RANGE = {2, 6};
  private float[] MIDDLE_FIRE_RATE_RANGE = {.4, 1};
  private boolean inMiddle;
  private int direction;

  public Alien(int posX, int posY, int direction, boolean inMiddle) {
    super(posX, posY, HITBOX, HITBOX,
      HEALTH, MOVEMENT_SPEED, SHOT_VELOCITY * direction, 0,
      direction == -1 ? loadImage("upsideDownAlien.png") : loadImage("alien.png"));
    this.fireRate = inMiddle ? chooseFromRange(MIDDLE_FIRE_RATE_RANGE) : chooseFromRange(FIRE_RATE_RANGE);
    this.inMiddle = inMiddle;
    //Outer aliens will start on cooldown
    this.onCooldown = inMiddle ? false :true;
    this.direction = direction;
  }

  public GameObject drawObject() {
    posX += movementSpeed;
    image(ship, posX, posY);
    Laser shot = null;
    if(!inMiddle || !AlienHandler.isAlienInFrontOf(this)){
      shot = shoot();
      handleCooldown();
    }
    return shot;
  }
  
  public int getDirection(){
    return direction;
  }
  
  public boolean inMiddle(){
    return inMiddle;
  }
  
  public float chooseFromRange(float[] range){
    return (float)(range[0] + Math.random() * (range[1] - range[0]));
  }
 
  public void reverseMovement(){
    movementSpeed *= -1;
  }
  
  public void incrementYPos(int increment){
    posY += increment;
  }
  
  public void takeDamage(int dmg){
    health -= dmg;
    toDelete = health <= 0 ? true : false;
  }
}
