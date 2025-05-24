public static class AlienHandler {
  //The max amount of times aliens can move vertically
  public final static int MAX_VERTICAL_SHIFT_COUNT = 10;
  //The range at which aliens will move vertically and move in the opposite direction
  public final static int[] HORIZONTAL_RANGE = {100, 1200};
  //How much pixels aliens move whenever they move vertically
  public final static int ROW_VERT_INCREMENT = 4;
  //Starting position of aliens
  public final static int ROW_START = 335;
  public final static int COL_START = 435;
  public final static int ALIEN_GAP = 60;
  private static Alien[][] aliens;
  private static int verticalShiftCount;

  //Processing makes the file "SpaceInvaders" an enclosing class by default so i need to pass it as a parameter
  //to silence this error when I try to instantiate Alien:
  //No enclosing instance of type SpaceInvaders is accessible. Must qualify the allocation with an enclosing instance of type SpaceInvaders (e.g. x.new A() where x is an instance of SpaceInvaders).
  public static void initAliens(SpaceInvaders sketch) {
    aliens = new Alien[3][8];
    verticalShiftCount = 0;
    for (int row = 0; row < aliens.length; row++) {
      for (int col = 0; col < aliens[row].length; col++) {
        aliens[row][col] = sketch.new Alien(COL_START +  col * ALIEN_GAP, ROW_START + row * ALIEN_GAP, getDirection(row, col), row == 1);
      }
    }
  }

  //Handles per frame logic of the aliens
  public static void step() {
    boolean hasShifted = false;
    for (int row = 0; row < aliens.length; row++) {
      for (int col = 0; col < aliens[row].length; col++) {
        Alien a = aliens[row][col];
        if (a != null) {
          if (!hasShifted && (a.getPosX() <= HORIZONTAL_RANGE[0] || a.getPosX() >= HORIZONTAL_RANGE[1])) {
            shiftAliens();
            hasShifted = true;
          }
          if (a.delete()) {
            aliens[row][col] = null;
          }
        }
      }
    }
  }

  //Shifts top aliens up, bottom aliens down, and reverses every alien's horizontal movement
  public static void shiftAliens() {
    for (int row = 0; row < aliens.length; row++) {
      for (int col = 0; col < aliens[row].length; col++) {
        Alien a = aliens[row][col];
        if (a != null) {
          if (row == 0 && verticalShiftCount < MAX_VERTICAL_SHIFT_COUNT) {
            a.incrementYPos(ROW_VERT_INCREMENT * -1);
          } else if (row == aliens.length - 1 && verticalShiftCount < MAX_VERTICAL_SHIFT_COUNT) {
            a.incrementYPos(ROW_VERT_INCREMENT);
          }
          a.reverseMovement();
        }
      }
    }
    verticalShiftCount += 1;
  }

  public static int getDirection(int row, int col) {
    if (row == 0) {
      return -1;
    }
    if (row == 1 && col < 4) {
      return - 1;
    }
    return 1;
  }

  public static boolean isAlienInFrontOf(Alien a) {
    if (!a.inMiddle()) {
      return false;
    }

    for (int col = 0; col < aliens[1].length; col++) {
      if (a == aliens[1][col]) {
        int direction = a.getDirection();
        return aliens[1 + direction][col] != null;
      }
    }

    //Theoretically this shouldn't be reached cause it means the alien doesn't exist
    return false;
  }

  public static ArrayList<Alien> getAlienList() {
    ArrayList<Alien> list = new ArrayList<Alien>();
    for (int i = 0; i < aliens.length; i++) {
      for (int j = 0; j < aliens[i].length; j++) {
        list.add(aliens[i][j]);
      }
    }
    return list;
  }
}
