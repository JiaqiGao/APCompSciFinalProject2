class Coord {
  int x;
  int y;

  public Coord(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public int getX() {
    return x;
  }

  public int getY() {
    return y;
  }
}


PImage map;
//ArrayList for each region
//I Don't Care about Korea
ArrayList<Coord> Europe = new ArrayList<Coord>();
ArrayList<Coord> NorthAmerica = new ArrayList<Coord>();
ArrayList<Coord> SouthAmerica = new ArrayList<Coord>();
ArrayList<Coord> GreenLand = new ArrayList<Coord>();
ArrayList<Coord> Russia = new ArrayList<Coord>();
ArrayList<Coord> China = new ArrayList<Coord>();
ArrayList<Coord> Africa = new ArrayList<Coord>();
ArrayList<Coord> Japan = new ArrayList<Coord>();
ArrayList<Coord> Australia = new ArrayList<Coord>();
ArrayList<Coord> Indonesia = new ArrayList<Coord>();

void setup() {
  size(800, 600);
  map = loadImage("worldmap.png");
  map.resize(800, 600);
  background(map);
  loadPixels();
  section();
}


void draw() {
  background(map);
  loadPixels();
  fill(0);
  text(get(mouseX, mouseY), 100, 120);
  text(pixels[width*mouseY+mouseX], 100, 160);
  check();
  //for(Coord pair : NorthAmerica){
  // pixels[width*pair.getY() + pair.getX()] = 0; 
  //}
  //updatePixels();
}



void section() {

  for (int i = 0; i<pixels.length; i++) {
    if (pixels[i] == -16733696) {
      NorthAmerica.add(new Coord(i%800, i/800));
    } else if (pixels[i] == -16734208) {
      SouthAmerica.add(new Coord(i%800, i/800));
    } else if (pixels[i] == -16733184) {
      GreenLand.add(new Coord(i%800, i/800));
    } else if (pixels[i] == -16735232) {
      Europe.add(new Coord(i%800, i/800));
    } else if (pixels[i] == -16734976) {
      Russia.add(new Coord(i%800, i/800));
    } else if (pixels[i] == -16734720) {
      China.add(new Coord(i%800, i/800));
    } else if (pixels[i] == -16733440) {
      Japan.add(new Coord(i%800, i/800));
    } else if (pixels[i] == -16734464) {
      Africa.add(new Coord(i%800, i/800));
    } else if (pixels[i] == -16733952) {
      Indonesia.add(new Coord(i%800, i/800));
    } else if (pixels[i] == -16733184) {
      Australia.add(new Coord(i%800, i/800));
    }
  }
}

void check() {
  for (int i = 0; i < NorthAmerica.size(); i++) {
    if (mouseX == NorthAmerica.get(i).getX() &&
      mouseY == NorthAmerica.get(i).getY()) {
      text("On North America", 100, 180);
    }
  }
  for (int i = 0; i < SouthAmerica.size(); i++) {
    if (mouseX == SouthAmerica.get(i).getX() &&
      mouseY == SouthAmerica.get(i).getY()) {
      text("On South America", 100, 180);
    }
  }
  for (int i = 0; i < GreenLand.size(); i++) {
    if (mouseX == GreenLand.get(i).getX() &&
      mouseY == GreenLand.get(i).getY()) {
      text("On Green Land", 100, 180);
    }
  }
  for (int i = 0; i < Europe.size(); i++) {
    if (mouseX == Europe.get(i).getX() &&
      mouseY == Europe.get(i).getY()) {
      text("On Europe", 100, 180);
    }
  }
  for (int i = 0; i < Russia.size(); i++) {
    if (mouseX == Russia.get(i).getX() &&
      mouseY == Russia.get(i).getY()) {
      text("On Russia", 100, 180);
    }
  }
  for (int i = 0; i < China.size(); i++) {
    if (mouseX == China.get(i).getX() &&
      mouseY == China.get(i).getY()) {
      text("On China", 100, 180);
    }
  }
  for (int i = 0; i < Japan.size(); i++) {
    if (mouseX == Japan.get(i).getX() &&
      mouseY == Japan.get(i).getY()) {
      text("On Japan", 100, 180);
    }
  }
  for (int i = 0; i < Africa.size(); i++) {
    if (mouseX == Africa.get(i).getX() &&
      mouseY == Africa.get(i).getY()) {
      text("On Africa", 100, 180);
    }
  }
  for (int i = 0; i < Indonesia.size(); i++) {
    if (mouseX == Indonesia.get(i).getX() &&
      mouseY == Indonesia.get(i).getY()) {
      text("On Indonesia", 100, 180);
    }
  }
  for (int i = 0; i < Australia.size(); i++) {
    if (mouseX == Australia.get(i).getX() &&
      mouseY == Australia.get(i).getY()) {
      text("On Australia", 100, 180);
    }
  }
}