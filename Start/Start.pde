import java.util.*;
import java.lang.*;

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

//start screen
PImage window;
boolean clickedOn = false;
boolean close = false;

//Infect the first person?
boolean first = true; 
boolean started = false;

//ArrayLisr which contains all region on the map
ArrayList<Region> world = new ArrayList<Region>();

//object for timer
Time timer = new Time();

DiseaseSpread s;


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
  window = loadImage("window.png");
  window.resize(400, 300);
  //create array of int for color code of each pixel
  //then assign coordinate to each region accordingly
  map.loadPixels();
  createRegions();
  //timer setup
  timer.runTime();
}


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
  //<<<<<<< HEAD
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

  //=======
  //Region NorthAmerica = new Region("North America", 360479324, NA, 5);
  //Region SouthAmerica = new Region("South America", 784247223, SA, 4);
  //Region Europe = new Region("Europe", 737849002, Eu, 5);
  //Region Greenland = new Region("Greenland", 57728, GL, 5);
  //Region Russia = new Region("Russia", 146300000, Ru, 4);
  //Region Asia = new Region("Asia", 1381537308, As, 3);
  //Region EastAsia = new Region("East Asia", 127034536, EA, 5);
  //Region Africa = new Region("Africa", 1216129815, Af, 2);
  //Region Australia = new Region("Australia", 24168303, Au, 4);
  //Region Indonesia = new Region("Indonesia", 29000000, In, 3);

  Europe.popInfected = 10000;
  // >>>>>>> bdd3558c90e4db3c48c6709b76b645e81e78f51e
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
  Bar progress = new Bar(844, 550, "World Annihilation");
  image(map, 0, 0);
  image(logo, 0, 500);
  loadPixels(); 
  timer.showTime();
  //if(s != null){
  //s.spread();
  //}
  fill(0);
  text(mouseX +"  "+ mouseY, 100, 100);
  text(get(mouseX, mouseY), 100, 130);
  //text(pixels[width*mouseY+mouseX], 100, 160);
  for (Region place : world) {
    text(place.check(), 130, 180);
    place.populationGrowth();
  }
  progress.createBar();
  if (started) {
    highlight();
  }
  if (started != true) {
    startScreen();
  }
  //Europe.infectedToDead();
  
  //int x = (int)Math.random()*width;
  //int y = (int)Math.random()*height;
  //s.spread(x,y);
  //s.showInfect();
}

void highlight() {
  int hcolor=0;
  boolean high = false;
  if (get(mouseX, mouseY) != -1) {
    high = true;
    hcolor = get(mouseX, mouseY);
  }
  if (high==true) {
    for (int i=0; i<1000; i++) {
      for (int j=0; j<600; j++) {
        if (get(i, j)==hcolor && get(i, j)<-1000000) {
          set(i, j, hcolor+500);
        }
      }
    }
  }
}

void startScreen() {
  window = loadImage("window.png");
  window.resize(400, 300);
  image(window, 300, 150);
  startText();
}

//<<<<<<< HEAD
//void startText() {
//int linespacing = 40;
//fill(255, 102, 103);
//textSize(20);
//text("The Deadly Sniffle Virus", 383, 210);
// =======
void startText() {
  int linespacing = 30;
  fill(138, 29, 29);
  textSize(16);
  text("YOUR MISSION IS TO DESTROY HUMANITY.", 335, 215); 
  fill(61, 15, 15);
  textSize(14);
  text("Equipped with the deadly Sniffles virus, kill as \nmany people as possible. \nSelect the region you would like your first victim \nto come from. \nAs more people get infected, you may choose \nhow you would like to mutate your virus as \nmore people get infected. \nSelect your mutations strategically as their effects \nwill differ based on the location of your victims.", 332, 215+linespacing);
  //    >>>>>>> bdd3558c90e4db3c48c6709b76b645e81e78f51e
}

void closeWindow() {
  if (close) {
    clickedOn = false;
    close = false;
  }
}

void mouseClicked() {

  for (Region place : world) {

    //when the mouse is hovering over the area, and mouse is clicked
    //set boolean clickedOn to true so that openWindow will run
    if (place.hovering) {
      place.clickedOn = true;
    }

    //if a window is opened, and mouse is clicked on the close button
    //window will disappear
    if (place.clickedOn && 
      mouseX >= 675 && mouseX <= 690 &&
      mouseY >= 155 && mouseY <= 170) {
      place.close = true;
    }
    if (started==false && 
      mouseX >= 675 && mouseX <= 690 &&
      mouseY >= 155 && mouseY <= 170) {
      started = true;
    }
  }
  //s = new DiseaseSpread(mouseX, mouseY);
}