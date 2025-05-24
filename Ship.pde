public abstract class Ship extends GameObject implements Damageable {
  //time cooldown active;
  protected float timeActive;
  protected boolean onCooldown;
  protected int health, movementSpeed, shotSpeed;
  protected float fireRate;
  protected PImage ship;

  protected Ship(int posX, int posY, int hitBoxX, int hitBoxY, int health, int movementSpeed, int shotSpeed, float fireRate, PImage ship) {
    super(posX, posY, hitBoxX, hitBoxY);
    this.timeActive = 0;
    this.onCooldown = false;
    this.health = health;
    this.movementSpeed = movementSpeed;
    this.shotSpeed = shotSpeed;
    this.fireRate = fireRate;
    this.ship = ship;
  }

  protected Laser shoot() {
    if (onCooldown) {
      return null;
    }

    GUN_SHOT.play();
    onCooldown = true;
    return new Laser(this);
  }

  public void handleCooldown() {
    if (onCooldown) {
      timeActive += 1/frameRate;
      if (timeActive >= fireRate) {
        onCooldown = false;
        timeActive = 0;
      }
    }
  }

  public int getHealth() {
    return health;
  }
  
  public int getShotVelocity() {
    return shotSpeed;
  }
  
  public boolean isPlayerShip(){
    return this instanceof Player;
  }

  public void takeDamage(int dmg) {
    health -= dmg;
    if (health <= 0) {
      toDelete = true;
    }
  }
}
