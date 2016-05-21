class Region {
  String name;
  int[] colorCode;
  int population, popAlive, popDead, popInfected;
  ArrayList<Coord> area = new ArrayList<Coord>();
  ArrayList pixel = new ArrayList();
  boolean hovering = false;
  boolean clickedOn = false;
  boolean close = false;
  PImage window;
  //Contructor sets variable to intial value
  public Region(String name, int population, int[] colorCode) {
    this.name = name;
    this.population = population;
    popAlive = population;
    popDead = 0;
    popInfected = 0;
    this.colorCode = colorCode;
    window = loadImage("window.png");
    window.resize(400, 300);
    //load coordinates into ArrayList if satisfied colorCode requirement
    for (int i = 0; i<map.pixels.length; i++) {
      for (int x = 0; x < colorCode.length; x++) { 
        if (map.pixels[i] == colorCode[x]) {
          area.add(new Coord(i%width, i/width));
          pixel.add(i);
        }
      }
    }
  }

  //return name
  public String getName() {
    return name;
  }

  //change color of the region
  void changeColor(int[] newColor) {
    //for (Coord pair : area) {
    //  if (mouseX == pair.getX() &&
    //    mouseY == pair.getY()) {
    //    for (int i = 0; i <pixel.size(); i++) {
    //      map.pixels[i] = color(newColor[0], newColor[1], newColor[2]);
    //    }
    //  }
    //}
    //for (int i = 0; i < pixel.size(); i++) {
    //  map.pixels[(int)pixel.get(i)] = color(newColor[0], newColor[1], newColor[2]);
    //  map.updatePixels();
    //}
    //newMap = loadImage("worldmap.png");
    //newMap.loadPixels();
    //for (int i = 0; i < pixel.size(); i++) {
    //  newMap.pixels[(int)pixel.get(i)] = color(newColor[0], newColor[1], newColor[2]);
    //}
    //newMap.updatePixels();
  }

  //checking if mouse on region, return region name to be printed on screen
  public String check() {
    openWindow();
    closeWindow();
    for (Coord pair : area) {
      if (mouseX == pair.getX() &&
        mouseY == pair.getY()) {
        hovering = true;
        return name;
      }
      hovering = false;
    }
    return "";
  }

  //create a window
  void openWindow() {
    if (clickedOn) {
      image(window, 300, 150);
      if (mouseX >= 675 && mouseX <= 693 &&
        mouseY >= 154 && mouseY <= 170) {
        fill(37, 140, 206, 150);
        noStroke();
        rect(675,154, 18, 17);
      }
    }
  }

  void closeWindow() {
    if (close) {
      clickedOn = false;
      close = false;
    }
  }
}