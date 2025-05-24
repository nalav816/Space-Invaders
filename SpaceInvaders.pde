import processing.sound.*;
import java.util.Iterator;

public SoundFile GUN_SHOT;
public SoundFile BARRIER_BROKEN;
public ArrayList<GameObject> objects;
public PImage BACKGROUND;
public boolean gameActive = false, endScreenActive = false;
public Integer gameWinner;
public HealthUI healthUI;

//GAME CONFIGS
public final int WIDTH = 1300, HEIGHT = 800;
public final int[][] barrierPositions = {
  {373, 600},
  {646, 600},
  {919, 600},
  {373, 200},
  {646, 200},
  {919, 200}
};
public final int[][] healthUIPositions = {
  {40, 764},
  {1180, 36}
};

public void settings() {
  size(WIDTH, HEIGHT);
}

public void initGame() {
  objects = new ArrayList<GameObject>();
  Player p1 = new Player(1);
  Player p2 = new Player(2);
  gameWinner = null;
  healthUI = new HealthUI(p1, p2);
  AlienHandler.initAliens(this);

  for (int i = 1; i <= 6; i++) {
    objects.add(new Barrier(i));
  }

  objects.add(p1);
  objects.add(p2);
  objects.addAll(AlienHandler.getAlienList());
}

public void setup() {
  GUN_SHOT = new SoundFile(this, "sounds/laserSound.wav");
  GUN_SHOT.amp(.5);
  BARRIER_BROKEN = new SoundFile(this, "sounds/barrierBreak.wav");
  BACKGROUND = loadImage("imgs/background.png");
}

public void drawTitle() {
  textSize(30);
  textAlign(CENTER);
  fill(255);
  text("Space Invaders", 650, 400);
  textSize(15);
  text("Have you ever played Space Invaders? How about with two people? Probably not. Well now you can try for the first time!", 650, 430);
  text("Click anywhere to start!", 650, 460);
}

public void endGame(ArrayList<Player> losingPlrs) {
  gameActive = false;
  endScreenActive = true;
  if (losingPlrs.size() == 1) {
    gameWinner = losingPlrs.get(0).getPlayerNum() == 1 ? 2 : 1;
  }
}

public void drawEndScreen() {
  textSize(30);
  textAlign(CENTER);
  fill(255);
  if (gameWinner != null) {
    text("Player " + gameWinner + " Won!", 650, 400);
  } else {
    text("Tie!", 650, 400);
  }
  textSize(15);
  text("Click anywhere to return to start.", 650, 430);
}

public void draw() {
  imageMode(CENTER);
  image(BACKGROUND, 650, 400);
  if (gameActive) {
    ArrayList<GameObject> toSpawn = new ArrayList<GameObject>();
    ArrayList<Player> losingPlrs = new ArrayList<Player>();
    Iterator<GameObject> itr = objects.iterator();
    while (itr.hasNext()) {
      GameObject next = itr.next();
      if (next.delete()) {
        if (next instanceof Player) {
          losingPlrs.add((Player)next);
        }
        itr.remove();
      } else {
        GameObject o = next.drawObject();
        if (o != null) {
          toSpawn.add(o);
        }
      }
    }
    objects.addAll(toSpawn);
    healthUI.drawUI();
    AlienHandler.step();
    if (losingPlrs.size() > 0) {
      endGame(losingPlrs);
    }
  } else {
    if (endScreenActive) {
      drawEndScreen();
    } else {
      drawTitle();
    }
  }
}

public void mousePressed() {
  if (endScreenActive) {
    endScreenActive = false;
  } else if (!gameActive) {
    initGame();
    gameActive = true;
  }
}

public void keyPressed() {
  if (gameActive) {
    for (GameObject o : objects) {
      if (o instanceof Player) {
        Player p = (Player) o;
        p.onInput();
      }
    }
  }
}

public void keyReleased() {
  if (gameActive) {
    for (GameObject o : objects) {
      if (o instanceof Player) {
        Player p = (Player) o;
        p.onInputReleased();
      }
    }
  }
}
