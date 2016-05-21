class Region {
  String name;
  int[] colorCode;
  int population, popAlive, popDead, popInfected;
  ArrayList<Coord> area = new ArrayList<Coord>();

  //Contructor sets variable to intial value
  public Region(String name, int population, int[] colorCode) {
    this.name = name;
    this.population = population;
    popAlive = population;
    popDead = 0;
    popInfected = 0;
    this.colorCode = colorCode;

    //load coordinates into ArrayList if satisfied colorCode requirement
    for (int i = 0; i<pixels.length; i++) {
      for (int x = 0; x < colorCode.length; x++) { 
        if (pixels[i] == colorCode[x]) {
          area.add(new Coord(i%width, i/width));
        }
      }
    }
  }

  //checking if mouse on region, return region name to be printed on screen
  public String check() {
    for (Coord pair : area) {
      if (mouseX == pair.getX() &&
        mouseY == pair.getY()) {
        return name;
      }
    }
    return "";
  }
}