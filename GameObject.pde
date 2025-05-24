public abstract class GameObject {
  protected boolean toDelete;
  protected int posX, posY, hitBoxX, hitBoxY;
  
  protected GameObject(int posX, int posY, int hitBoxX, int hitBoxY){
    this.toDelete = false;
    this.posX = posX;
    this.posY = posY;
    this.hitBoxX = hitBoxX;
    this.hitBoxY = hitBoxY;
  }
  
  public abstract GameObject drawObject();
  
  public int getPosX(){
    return posX;
  }
  
  public int getPosY(){
    return posY;
  }
  
  //first index x, second y. Top left corner
  public int[] getBottomHitBoxVertex(){
    return new int[]{hitBoxX/2 + posX, posY + hitBoxY/2};
  }
  
  //Bottom right corner
  public int[] getTopHitBoxVertex(){
    return new int[]{posX - hitBoxX/2, posY - hitBoxY/2};
  }
  
  public boolean isColliding(GameObject other){
     if(this == other){ return false; }
     //Explosion's don't trigger collisions
     if(other instanceof Explosion){ return false; }
     
     int[] currTop = getTopHitBoxVertex();
     int[] currBottom = getBottomHitBoxVertex();
     int[] otherTop = other.getTopHitBoxVertex();
     int[] otherBottom = other.getBottomHitBoxVertex();
     
     if(currBottom[1] < otherTop[1] || currBottom[0] < otherTop[0]){
       return false;
     } else if (currTop[1] > otherBottom[1] || currTop[0] > otherBottom[0]){
       return false;
     }
     
     return true;
  }
  
  public boolean delete(){
     return toDelete;
  }
}
