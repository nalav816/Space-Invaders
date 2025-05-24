import processing.sound.*;

class Player extends Ship {
  private static final int PLAYER_HEALTH = 3;

  //Seconds per shot
  private static final float STARTING_FIRE_RATE = .8;
  private static final int STARTING_SHIP_SPEED = 2;
  private static final int HITBOX_SIZE = 60;
  private static final int STARTING_PROJECTILE_SPEED = 8;

  private int plr;
  private boolean leftDown, rightDown, shootDown;
  private Object left, right, shoot;

  public Player(int playerNumber) {
    super(650, playerNumber == 1 ? 700 : 100, HITBOX_SIZE, HITBOX_SIZE, PLAYER_HEALTH, STARTING_SHIP_SPEED, STARTING_PROJECTILE_SPEED * (playerNumber == 1 ? -1 : 1), STARTING_FIRE_RATE, loadImage("imgs/Rocket" + playerNumber + ".png"));
    this.plr = playerNumber;
    this.leftDown = false;
    this.rightDown = false;
    this.shootDown = false;
    this.left = plr == 1 ? (Object) LEFT : (Object) 'a';
    this.right = plr == 1 ? (Object) RIGHT : (Object) 'd';
    this.shoot = plr == 1 ? ' ' : 'q';
  }

  public GameObject drawObject() {
    posX += (rightDown ? movementSpeed : 0) + (leftDown ? -movementSpeed : 0);
    posX = Math.min(WIDTH - HITBOX_SIZE/2, posX);
    posX = Math.max(HITBOX_SIZE/2, posX);
    imageMode(CENTER);
    image(ship, posX, posY);
    handleCooldown();
    return shootDown ? shoot() : null;
  }

  public int getPlayerNum() {
    return plr;
  }
  
  public void buffStats() {
    this.fireRate *= .95;
    this.movementSpeed += 1;
    this.shotSpeed += 1;
  }

  public void onInput() {
    if ((left instanceof Character && Character.toLowerCase(key) == (char)left) || (left instanceof Integer && keyCode == (Integer)left)) {
      leftDown = true;
    } else if ((right instanceof Character && Character.toLowerCase(key) == (char)right) || (right instanceof Integer && keyCode == (Integer)right)) {
      rightDown = true;
    } else if (shoot instanceof Character && Character.toLowerCase(key) == (char)shoot) {
      shootDown = true;
    }
  }

  public void onInputReleased() {
    if ((left instanceof Character && Character.toLowerCase(key) == (char)left) || (left instanceof Integer && keyCode == (Integer)left)) {
      leftDown = false;
    } else if ((right instanceof Character && Character.toLowerCase(key) == (char)right) || (right instanceof Integer && keyCode == (Integer)right)) {
      rightDown = false;
    } else if (shoot instanceof Character && Character.toLowerCase(key) == (char)shoot) {
      shootDown = false;
    }
  }
}
