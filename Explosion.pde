public class Explosion extends GameObject{
  private static final float EXPLOSION_DURATION = .4;
  private float timeActive;
  private PImage img;
  
  public Explosion(int posX, int posY) {
     super(posX, posY, 0, 0);
     this.img = loadImage("explosion.png");
     this.timeActive = 0;
     
  }

  public GameObject drawObject() {
    image(img, posX, posY);
    timeActive += 1/frameRate;
    if(timeActive >= EXPLOSION_DURATION){
       toDelete = true;
    }
    return null;
  }
}
