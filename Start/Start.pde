import java.util.*; //<>// //<>// //<>//
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

  public int getColor() {
    return get(x, y);
  }

  //compare two Coord objects
  public boolean equals(Coord pair) {
    if (pair.getX() == x &&
      pair.getY() == y) {
      return true;
    }
    return false;
  }

  public void changeColor(int c) {
    set(x, y, c);
  }

  //which country this coordinate is on
  public String getCountry() {
    String countryName = "";
    for (Region place : world) {
      if (place.has(new Coord(x, y))) {
        countryName = place.getName();
        break;
      }
    }
    return countryName;
  }

  public Region getRegion() {
    Region r = world.get(0);
    //String countryName = "";
    for (Region place : world) {
      if (place.has(new Coord(x, y))) {
        //countryName = place.getName();
        r = place;
        break;
      }
    }
    return r;
  }
}

//load image
PImage map;
PImage logo;

//start screen
PImage window;
boolean clickedOn = false;
boolean close = false;

//point system for mutations
//cheat int totalInfect = 5000;
int resistanceCost = 45;
int symptomsCost = 50;

//Infect the first person?
boolean infectButton = false; 
boolean started = false;
boolean openingGift = true;

Region clickRegion; 
//ArrayLisr which contains all region on the map
ArrayList<Region> world = new ArrayList<Region>();
//ArrayList<Region> infectedRegions = new ArrayList<Region>();
ArrayList<Bar> bars = new ArrayList<Bar>();
Region firstRegion;

//object for timer
Time timer = new Time();

//disease
boolean canInfect;
//create area of infectable
ArrayList<Coord> infectable = new ArrayList<Coord>();
ArrayList<Coord> infected = new ArrayList<Coord>();
//ArrayList of all disease
ArrayList<DiseaseSpread> allDisease = new ArrayList<DiseaseSpread>();

//check which region mouse is hovering over
String currentCountry = "";

//whether player had selected the region to infect yet
boolean select = false;


void setup() {
  //window size
  size(1000, 600);
  frameRate(60);
  //load map as background
  map = loadImage("worldmap.png");
  map.resize(1000, 600);
  background(map);
  //load logo
  logo = loadImage("sniffles.png");
  logo.resize(100, 100);
  //image(logo, 0, 500);
  window = loadImage("window.png");
  window.resize(400, 300);

  //create array of int for color code of each pixel
  //then assign coordinate to each region accordingly
  map.loadPixels();
  loadPixels();
  createRegions();
  createBars();

  //timer setup
  timer.runTime();
}

void createBars() {
  Bar progress = new Bar(844, 550, "World Annihilation", 120, 25, true);
  Bar mutations = new Bar(820, 17, "Mutations", 100, 30, true);
  Bar resistances = new Bar(337, 309, "Resistances", 120, 35, false);
  Bar symptoms = new Bar(534, 309, "Symptoms", 120, 35, false);
  bars.add(progress);
  bars.add(mutations);
  bars.add(resistances);
  bars.add(symptoms);
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
  //background(255);
  image(map, 0, 0);
  image(logo, 0, 500);
  loadPixels(); 
  showInfectPoints();
  timer.showTime();
  //fill(0);
  //text(mouseX +"  "+ mouseY, 100, 100);
  text(get(mouseX, mouseY), 100, 130);
  //text(pixels[width*mouseY+mouseX], 100, 160);
  for (Region place : world) {
    place.check();
    //text(place.check(), 130, 180);
    //update population : alive, infected, dead
    place.populationChange();
  }
  bars.get(0).createBar();
  for (int i=1; i<bars.size(); i++) {
    if (bars.get(i).visible == true) {
      bars.get(i).createButton();
    }
  }
  if (started) {
    highlight();
  }
  if (started != true) {
    startScreen();
  }

  //for each existing infection, spread accordingly
  for (DiseaseSpread infection : allDisease) {
    infection.spread();
    infection.show();
  }
  //instruction of what player should do next
  if(select){
    fill(142,142,142,150);
    rect(mouseX+15,mouseY+18,178,13);
    fill(0);
    textSize(10);
    text("Select where the virus should start",mouseX+20,mouseY+28); 
  }
}

void highlight() {
  int hcolor=0;
  boolean high = false;
  if (get(mouseX, mouseY) != -1) {
    high = true;
    hcolor = get(mouseX, mouseY);
  }
  if(select){
    high = false;
  }
  if (high == true) {
    Region match = matchRegion(mouseX, mouseY);
    for (Coord c : match.area) {
      if (c.getColor() < -1000000 && c.getColor()==hcolor) {
        c.changeColor(hcolor+500);
      }
    }
  }
  /*
  if (high==true) {
   for (int i=0; i<1000; i++) {
   for (int j=0; j<600; j++) {
   if (get(i, j)==hcolor && get(i, j)<-1000000) {
   set(i, j, hcolor+500);
   }
   }
   }
   
   }*/
}

void showInfectPoints() {
  textSize(25);
  fill(45, 152, 175);
  text("XP: "+ totalInfect, 650, 550);
}

void startScreen() {
  window = loadImage("window.png");
  window.resize(400, 300);
  image(window, 300, 150);
  startText();
}

void startText() {
  int linespacing = 30;
  fill(138, 29, 29);
  textSize(16);
  text("YOUR MISSION IS TO DESTROY HUMANITY.", 335, 215); 
  fill(61, 15, 15);
  textSize(14);
  text("Equipped with the deadly Sniffles virus, kill as \nmany people as possible. \nSelect the region you would like your first victim \nto come from. \nAs more people get infected, you may choose \nhow you would like to mutate your virus as \nmore people get infected. \nSelect your mutations strategically as their effects \nwill differ based on the location of your victims.", 332, 215+linespacing);
}

void closeWindow() {
  if (close) {
    clickedOn = false;
    close = false;
  }
}

public Region matchRegion(int x, int y) {
  int tempColor = get(x, y);
  for (Region r : world) {
    for (int i : r.colorCode) {
      if (tempColor == i) {
        return r;
      }
    }
  }
  return world.get(0);
}
/*
void initiateDeathSequence() {
 //int firstPixel;
 while (get(mouseX, mouseY) == -1) {
 firstRegion = matchRegion(mouseX, mouseY);
 }
 System.out.println(firstRegion);
 first = true;
 if (first==true) {
 //firstPixel = firstRegion.coordinates.get((int)(Math.random()*firstRegion.coordinates.size()));
 //firstRegion.virus(firstPixel);
 //System.out.println(firstPixel);
 //first = false;
 }
 }
 */
void mouseClicked() {
  
  if(select){
   allDisease.add(new DiseaseSpread(1));
   select = false;
  }

  for (Region place : world) {
    //when the mouse is hovering over the area, and mouse is clicked
    //set boolean clickedOn to true so that openWindow will run
    if (!select && place.hovering && !bars.get(2).visible && !bars.get(3).visible) {
      place.clickedOn = true;
      clickRegion = place;
    }
    if (clickRegion != null) {

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
      //if click x button
      if ((bars.get(1).mutationWindow == true || bars.get(2).mutationWindow == true || bars.get(3).mutationWindow == true ) && mouseX >= 675 && mouseX <= 690 &&
        mouseY >= 155 && mouseY <= 170) {
        bars.get(1).mutationWindow = false;
        bars.get(2).visible = false;
        bars.get(2).mutationWindow = false;
        bars.get(3).visible = false;
        bars.get(3).mutationWindow = false;
      }
      //if click mutations button
      if (mouseX >= bars.get(1).xcor && mouseX <= bars.get(1).xcor+bars.get(1).w &&
        mouseY >= bars.get(1).ycor && mouseY <= bars.get(1).ycor+bars.get(1).l) {
        bars.get(1).mutationWindow = true;
        bars.get(2).visible = true;
        bars.get(3).visible = true;
        //bars.get(3).
      }
      //if click resistances button 
      if (mouseX >= bars.get(2).xcor && mouseX <= bars.get(2).xcor+bars.get(2).w &&
        mouseY >= bars.get(2).ycor && mouseY <= bars.get(2).ycor+bars.get(2).l && !bars.get(3).mutationWindow) {
        //bars.get(1).visible = false;
        bars.get(1).mutationWindow = false;
        bars.get(3).visible = false;
        bars.get(2).mutationWindow = true;
        //bars.get(3).
      }

      //checking boxes in symptoms window
      if (bars.get(3).mutationWindow) {
        //344, 264+checkspacing
        if (mouseX >= 344 && mouseX <= 364 && totalInfect >= symptomsCost) {
          if (!bars.get(3).checks[0] && mouseY >= 264 && mouseY <= 282) {
            bars.get(3).checks[0] = true;
            totalInfect -= symptomsCost;
          }
          if (!bars.get(3).checks[1] && mouseY >= 300 && mouseY <= 318) {
            bars.get(3).checks[1] = true;
            totalInfect -= symptomsCost;
          }
          if (!bars.get(3).checks[2] && mouseY >= 336 && mouseY <= 354) {
            bars.get(3).checks[2] = true;
            totalInfect -= symptomsCost;
          }
          if (!bars.get(3).checks[3] && mouseY >= 372 && mouseY <= 390) {
            bars.get(3).checks[3] = true;
            totalInfect -= symptomsCost;
          }
        }
      }

      //if click symptoms button
      if (mouseX >= bars.get(3).xcor && mouseX <= bars.get(3).xcor+bars.get(3).w &&
        mouseY >= bars.get(3).ycor && mouseY <= bars.get(3).ycor+bars.get(3).l) {
        //bars.get(1).visible = false;
        bars.get(1).mutationWindow = false;
        bars.get(2).visible = false;
        //bars.get(3).visible = false;
        bars.get(2).mutationWindow = false;
        bars.get(3).mutationWindow = true;
        //bars.get(3).
      }
      //resistances
      if (bars.get(2).mutationWindow) {
        //air
        if (mouseY >= 257 && mouseY <= 287 && totalInfect >= resistanceCost) {
          if (!bars.get(2).resistances[0][0] && mouseX >= 409 && mouseX <= 419) {
            bars.get(2).resistances[0][0] = true;
            totalInfect -= resistanceCost;
          }
          if (!bars.get(2).resistances[0][1] && mouseX >= 429 && mouseX <= 439 && bars.get(2).resistances[0][0]) {
            bars.get(2).resistances[0][1] = true;
            totalInfect -= resistanceCost;
          }  
          if (!bars.get(2).resistances[0][2] && mouseX >= 449 && mouseX <= 459 && bars.get(2).resistances[0][0] && bars.get(2).resistances[0][1]) {
            bars.get(2).resistances[0][2] = true;
            totalInfect -= resistanceCost;
          }  
          if (!bars.get(2).resistances[0][3] && mouseX >= 469 && mouseX <= 479 && bars.get(2).resistances[0][0] && bars.get(2).resistances[0][1] && bars.get(2).resistances[0][2]) {
            bars.get(2).resistances[0][3] = true;
            totalInfect -= resistanceCost;
          }  
          if (!bars.get(2).resistances[0][4] && mouseX >= 489 && mouseX <= 499 && bars.get(2).resistances[0][0] && bars.get(2).resistances[0][1] && bars.get(2).resistances[0][2] && bars.get(2).resistances[0][3]) {
            bars.get(2).resistances[0][4] = true;
            totalInfect -= resistanceCost;
          }
        }

        //water
        if (mouseY >= 307 && mouseY <= 337) {
          if (!bars.get(2).resistances[1][0] && mouseX >= 409 && mouseX <= 419) {
            bars.get(2).resistances[1][0] = true;
            totalInfect -= resistanceCost;
          }
          if (!bars.get(2).resistances[1][1] && mouseX >= 429 && mouseX <= 439 && bars.get(2).resistances[1][0]) {
            bars.get(2).resistances[1][1] = true;
            totalInfect -= resistanceCost;
          }  
          if (!bars.get(2).resistances[1][2] && mouseX >= 449 && mouseX <= 459 && bars.get(2).resistances[1][0] && bars.get(2).resistances[1][1]) {
            bars.get(2).resistances[1][2] = true;
            totalInfect -= resistanceCost;
          }  
          if (!bars.get(2).resistances[1][3] && mouseX >= 469 && mouseX <= 479 && bars.get(2).resistances[1][0] && bars.get(2).resistances[1][1] && bars.get(2).resistances[1][2]) {
            bars.get(2).resistances[1][3] = true;
            totalInfect -= resistanceCost;
          }  
          if (!bars.get(2).resistances[1][4] && mouseX >= 489 && mouseX <= 499 && bars.get(2).resistances[1][0] && bars.get(2).resistances[1][1] && bars.get(2).resistances[1][2] && bars.get(2).resistances[1][3]) {
            bars.get(2).resistances[1][4] = true;
            totalInfect -= resistanceCost;
          }
        }

        //heat
        if (mouseY >= 357 && mouseY <= 387) {
          if (!bars.get(2).resistances[2][0] && mouseX >= 409 && mouseX <= 419) {
            bars.get(2).resistances[2][0] = true;
            totalInfect -= resistanceCost;
          }
          if (!bars.get(2).resistances[2][1] && mouseX >= 429 && mouseX <= 439 && bars.get(2).resistances[2][0]) {
            bars.get(2).resistances[2][1] = true;
            totalInfect -= resistanceCost;
          }  
          if (!bars.get(2).resistances[2][2] && mouseX >= 449 && mouseX <= 459 && bars.get(2).resistances[2][0] && bars.get(2).resistances[2][1]) {
            bars.get(2).resistances[2][2] = true;
            totalInfect -= resistanceCost;
          }  
          if (!bars.get(2).resistances[2][3] && mouseX >= 469 && mouseX <= 479 && bars.get(2).resistances[2][0] && bars.get(2).resistances[2][1] && bars.get(2).resistances[2][2]) {
            bars.get(2).resistances[2][3] = true;
            totalInfect -= resistanceCost;
          }  
          if (!bars.get(2).resistances[2][4] && mouseX >= 489 && mouseX <= 499 && bars.get(2).resistances[2][0] && bars.get(2).resistances[2][1] && bars.get(2).resistances[2][2] && bars.get(2).resistances[2][3]) {
            bars.get(2).resistances[2][4] = true;
            totalInfect -= resistanceCost;
          }
        }
      }
      //437, 398, 100, 35
      if (infectButton && (mouseX >= 437 && mouseX <= 537 &&
        mouseY >= 398 && mouseY <= 433)) {
        //infectedRegions.add(clickRegion);
        // clickRegion.popInfected += 1;
        //allDisease.add(new DiseaseSpread(1));
        clickRegion.startInfection = true;
        if (openingGift) {
          openingGift = false;
        }else{
         totalInfect -= 1000; 
        }
        infectButton=false;
        select = true;
        //WAIT IM WORKING HERE
      }

      //when user click on area, infect the location and create a disease
      //testing initial value of disease set to 2 for now
      //if (clickRegion.startInfection) {
      //  allDisease.add(new DiseaseSpread(1));
      //  //clickRegion.startInfection = false;
      //}
    }
  }
}