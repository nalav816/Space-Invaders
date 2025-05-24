public class HealthUI {
  private static final int ICON_GAP = 40;
  private PImage icon;
  private Damageable p1, p2;
  
  public HealthUI(Damageable p1, Damageable p2){
    this.icon = loadImage("lifeIcon.png");
    this.p1 = p1;
    this.p2 = p2;
  }
  
  public void drawUI(){
    drawPlayerHealth(p1);
    drawPlayerHealth(p2);
  }
  
  public void drawPlayerHealth(Damageable plr){
    int posIndex = plr == p1 ? 0 : 1;
    int x = healthUIPositions[posIndex][0];
    int y = healthUIPositions[posIndex][1];
    for(int i = 0; i < plr.getHealth(); i++){
      image(icon, x + i * ICON_GAP, y);
    }
  }
}
