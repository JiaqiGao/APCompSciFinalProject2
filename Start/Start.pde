
//Class for coordinates on the map
class Coord {
  int x;
  int y;

  public Coord(int x, int y) {
    this.x = x;
    this.y = y;
  }

  //return x coordinate
  public int getX() {
    return x;
  }

  //return y coordinate
  public int getY() {
    return y;
  }
}

//load image
PImage map;
PImage logo;
//PImage newMap;

//ArrayLisr which contains all region on the map
ArrayList<Region> world = new ArrayList<Region>();

//boolean change = true;
//boolean[] window = {false,false,false,false,false,false,false,false,false,false};

void setup() {
  //window size
  size(1000, 600);
  //load map as background
  map = loadImage("worldmap.png");
  map.resize(1000, 600);
  background(map);
  //load logo
  logo = loadImage("sniffles.png");
  logo.resize(100, 100);
  image(logo, 0, 500);
  //create array of int for color code of each pixel
  //then assign coordinate to each region accordingly
  map.loadPixels();
  createRegions();
  //if (change) {
  //  Region test = world.get(0);
  //  ArrayList hmm = test.pixel;
  //  for (int i = 0; i<hmm.size(); i++) {
  //    map.pixels[(int)hmm.get(i)] = color(255, 251, 126);
  //    updatePixels();
  //  }
  //  change = false;
  //}
}
//
//assign coordinates to regions
void createRegions() {
  //color code for each region
  int[] NA = {-16733696, -2};
  int[] SA = {-16734208};
  int[] GL = {-16732672};
  int[] Eu = {-16735232};
  int[] Ru = {-16734976};
  int[] As = {-16734720};
  int[] EA = {-16733440, -65537};
  int[] Af = {-16734464};
  int[] In = {-16733952, -257};
  int[] Au = {-16733184};
  //create Region
  Region NorthAmerica = new Region("North America", 360479324, NA);
  Region SouthAmerica = new Region("South America", 784247223, SA);
  Region Europe = new Region("Europe", 737849002, Eu);
  Region Greenland = new Region("Greenland", 57728, GL);
  Region Russia = new Region("Russia", 146300000, Ru);
  Region Asia = new Region("Asia", 1381537308, As);
  Region EastAsia = new Region("East Asia", 127034536, EA);
  Region Africa = new Region("Africa", 1216129815, Af);
  Region Australia = new Region("Australia", 24168303, Au);
  Region Indonesia = new Region("Indonesia", 29000000, In);
  //add each Region to world
  world.add(NorthAmerica);
  world.add(SouthAmerica);
  world.add(Europe);
  world.add(Greenland);
  world.add(Russia);
  world.add(Asia);
  world.add(EastAsia);
  world.add(Africa);
  world.add(Australia);
  world.add(Indonesia);
}

void draw() {
  background(255);
  image(map, 0, 0);
  //image(logo, 0, 500);
  //check
  loadPixels();
  //int[] newColor = {255, 251, 126}; 
  fill(0);
  text(mouseX +"  "+ mouseY,100,100);
  text(get(mouseX, mouseY), 100, 120);
  text(pixels[width*mouseY+mouseX], 100, 160);
  for (Region place : world) {
    text(place.check(), 130, 180);
    //if(place.window){
    // place.openWindow(); 
    //}
    //place.changeColor(newColor);
  }
  //world.get(0).openWindow();
  //Region x = world.get(0);
  //for (Coord pair : x.area) {
  //  if (mouseX == pair.getX() && mouseY == pair.getY()) {
  //    change = true;
  //  } else {
  //    change = false;
  //  }
  //}
  //if (change) {
  //  change = false;
  //  x.changeColor(newColor);
  //  image(newMap, 0, 0);
  //}
  
}

void mouseClicked() {
  for (Region place : world) {
    //for (Coord pair : place.area) {
    //  if (mouseX == pair.getX() && mouseY == pair.getY()) {
    //    place.openWindow();
    //  }
    //}
    if(place.hovering){
     place.clickedOn = true; 
    }
    if(place.clickedOn && 
    mouseX >= 675 && mouseX <= 690 &&
    mouseY >= 155 && mouseY <= 170){
      place.close = true;
    }
  }
}

//void popup(){
// for(int i = 0; i < window.length; i++){
//  if(window[i]){
//   world.get(i).openWindow(); 
//  }
// }
//}