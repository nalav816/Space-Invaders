class Laser extends GameObject {
  private static final int LASER_DMG = 1;
  private static final int STARTING_Y_OFFSET = 60;
  private static final int HITBOX_X = 8, HITBOX_Y = 25;
  private static final int DESPAWN_DISTANCE = 100;
  private PImage laserImage;
  private int deltaY;
  private GameObject shooter;
  
  public Laser(Ship shooter) {
    super(shooter.getPosX(), -1000, HITBOX_X, HITBOX_Y);
    int sign = shooter.getShotVelocity() > 0 ? 1 : -1;
    this.laserImage = loadImage(shooter.isPlayerShip() ? (sign == -1 ? "imgs/ShotP1.png" : "imgs/ShotP2.png") : (sign == -1 ? "imgs/ShotA1.png" : "imgs/ShotA2.png"));
    this.posY = STARTING_Y_OFFSET * sign + shooter.getPosY();
    this.deltaY = shooter.getShotVelocity();
    this.shooter = shooter;
  }
  
  public GameObject drawObject() {
    posY += deltaY;
    image(laserImage, posX, posY);
    if(posY <= -1 * DESPAWN_DISTANCE || posY - HEIGHT > DESPAWN_DISTANCE){
      toDelete = true;
    }
    
    for(GameObject o : objects){
      if(isColliding(o) && o instanceof Damageable){
        Damageable d = (Damageable) o;
        d.takeDamage(LASER_DMG);
        toDelete = true;
        GameObject target = (GameObject) d;
        if(shooter instanceof Player && (target.delete() && target instanceof Alien)){
          Player p = (Player) shooter;
          p.buffStats();
        }
        return new Explosion(posX,posY);
      }
    }
    
    return null;
  }
}
