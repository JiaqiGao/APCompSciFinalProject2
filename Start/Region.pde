////<<<<<<< HEAD
//class Region {
//  String name;
//  int[] colorCode;
//  int population, popAlive, popDead, popInfected;
//  int growthFactor;
//  float E = 2.7182818284590452353602875;
//  ArrayList<Coord> area = new ArrayList<Coord>();
//  ArrayList pixel = new ArrayList();
//  boolean hovering = false;
//  boolean clickedOn = false;
//  boolean close = false;
//  PImage window;
//  DiseaseSpread disease = new DiseaseSpread(area);
//  boolean startInfection;

//  //Contructor sets variable to intial value
//  public Region(String name, int population, int[] colorCode) {
//    this.name = name;
//    this.population = population;
//    popAlive = population;
//    popDead = 0;
//    popInfected = 0;
//    this.colorCode = colorCode;
//    window = loadImage("window.png");
//    window.resize(400, 300);
//    //load coordinates into ArrayList if satisfied colorCode requirement
//    for (int i = 0; i<map.pixels.length; i++) {
//      for (int x = 0; x < colorCode.length; x++) { 
//        if (map.pixels[i] == colorCode[x]) {
//          area.add(new Coord(i%width, i/width));
//          pixel.add(i);
//        }
//      }
//    }
//    //random population growth
//    growthFactor = (int)(Math.random()*0.0001);
//  }

//  //return name
//  public String getName() {
//    return name;
//  }

//  //checking if mouse on region, return region name to be printed on screen
//  //and check if program should open/close a window
//  public String check() {
//    openWindow();
//    closeWindow();
//    infection();
//    disease.showInfect();
//    //if(startInfection){
//    // disease.spread(); 
//    // disease.showInfect();
//    //}

//    //populationGrowth();
//    //if mouse over area, make boolean hovering true
//    for (Coord pair : area) {
//      if (mouseX == pair.getX() &&
//        mouseY == pair.getY()) {
//        hovering = true;
//        return name;
//      }
//      hovering = false;
//    }
//    return "";
//  }

//  //create a window when mouse click on the area
//  void openWindow() {
//    if (clickedOn) {
//      image(window, 300, 150);
//      windowinfo();
//      //if mouse over close button, "highlight" the button
//      if (mouseX >= 675 && mouseX <= 693 &&
//        mouseY >= 154 && mouseY <= 170) {
//        fill(37, 140, 206, 150);
//        noStroke();
//        rect(675, 154, 18, 17);
//      }
//    }
//  }

//  void windowinfo() {
//    int linespacing = 40;
//    String newPop = commify(Integer.toString(population));
//    String newInfect = commify(Integer.toString(popInfected));
//    String newAlive = commify(Integer.toString(popAlive));
//    String newDead = commify(Integer.toString(popDead));
//    fill(0, 102, 153);
//    textSize(20);
//    text(name, 475-(2.5*name.length()), 210); 
//    textSize(16);
//    text("Population: " + newPop, 330, 210+(1*linespacing));
//    text("Population Infected: " + newInfect, 330, 210+(2*linespacing));
//    text("Population Alive: " + newAlive, 330, 210+(3*linespacing));
//    text("Population Dead: " + newDead, 330, 210+(4*linespacing));
//    if (first) {
//      fill(225, 60, 49);
//      text("INFECT", 470, 215+(5*linespacing));
//    }
//  }

//  String commify(String pop) {
//    int commacount = 0;
//    String newpop = "";
//    for (int i=pop.length()-1; i>-1; i--) {
//      commacount++;
//      newpop = pop.charAt(i) + newpop;
//      if (commacount == 3 && i>0) {
//        newpop = "," + newpop;
//        commacount = 0;
//      }
//    }
//    return newpop;
//  }

//  //close window when close button is clicked
//  void closeWindow() {
//    if (close) {
//      clickedOn = false;
//      close = false;
//    }
//  }

//  void populationGrowth() {
//    //population = (int)(population * Math.pow(E,(growthFactor*millis()/1000)));
//    population += 1;
//    if (hovering) {
//      text(population, 100, 250);
//    }
//  }

//  void infection() {
//    //also add another boolean later to make sure only start infecting
//    //when user decide to infect
//    if (clickedOn) {
//      //clickedOn = false;
//      //disease = new DiseaseSpread(mouseX,mouseY,area);
//      //startInfection = true;
//      disease.spread();
//    }
//  }
//}
//=======
class Region {
  String name;
  int[] colorCode;
  ArrayList<Integer> coordinates = new ArrayList<Integer>();
  int population, popAlive, popDead, popInfected;
  int growthFactor;
  float E = 2.7182818284590452353602875;
  ArrayList<Coord> area = new ArrayList<Coord>();
  ArrayList pixel = new ArrayList();
  boolean hovering = false;
  boolean clickedOn = false;
  boolean close = false;
  PImage window;
  DiseaseSpread disease = new DiseaseSpread(area); 
  boolean startInfection;

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
          coordinates.add(i);
        }
      }
      /*
       for(int r = 0; r<1000; r++){
       for(int j = 0; j<600; j++){
       for(int x : colorCode){
       if(get(r,j) == x){
       List<Integer> store = new ArrayList<Integer>();
       store.add(r);
       store.add(j);
       coordinates.add(new ArrayList<Integer>(store));
       }
       }
       }
       }*/
    }
    //random population growth
    growthFactor = (int)(Math.random()*0.0001);
  }

  //return name
  public String getName() {
    return name;
  }
  
  //check if a coord object is in area arraylist
  public boolean has(Coord pair){
   for(Coord current : area){
    if(current.equals(pair)){
     return true; 
    }
   }
   return false;
  }

  //checking if mouse on region, return region name to be printed on screen
  //and check if program should open/close a window
  public String check() {
    openWindow();
    closeWindow();
    infection();
    disease.showInfect();
    //if mouse over area, make boolean hovering true
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

  //create a window when mouse click on the area
  void openWindow() {
    if (clickedOn) {
      image(window, 300, 150);
      windowinfo();
      //if mouse over close button, "highlight" the button
      if (mouseX >= 675 && mouseX <= 693 &&
        mouseY >= 154 && mouseY <= 170) {
        fill(37, 140, 206, 150);
        noStroke();
        rect(675, 154, 18, 17);
      }
    }
  }

  void windowinfo() {
    int linespacing = 40;
    String newPop = commify(Integer.toString(population));
    String newInfect = commify(Integer.toString(popInfected));
    String newAlive = commify(Integer.toString(popAlive));
    String newDead = commify(Integer.toString(popDead));
    fill(0, 102, 153);
    textSize(20);
    text(name, 475-(2.5*name.length()), 210); 
    textSize(16);
    text("Population: " + newPop, 330, 210+(1*linespacing));
    text("Population Infected: " + newInfect, 330, 210+(2*linespacing));
    text("Population Alive: " + newAlive, 330, 210+(3*linespacing));
    text("Population Dead: " + newDead, 330, 210+(4*linespacing));
    if (first) {
      fill(225, 60, 49);
      text("INFECT", 470, 215+(5*linespacing));
    }
  }

  String commify(String pop) {
    int commacount = 0;
    String newpop = "";
    for (int i=pop.length()-1; i>-1; i--) {
      commacount++;
      newpop = pop.charAt(i) + newpop;
      if (commacount == 3 && i>0) {
        newpop = "," + newpop;
        commacount = 0;
      }
    }
    return newpop;
  }

  //close window when close button is clicked
  void closeWindow() {
    if (close) {
      clickedOn = false;
      close = false;
    }
  }

  void populationGrowth() {
    //population = (int)(population * Math.pow(E,(growthFactor*millis()/1000)));
    population += 1;
    popAlive += 1;
    if (hovering) {
      text(population, 100, 250);
    }
  }

  void infection() {
    //also add another boolean later to make sure only start infecting
    //when user decide to infect
    if (clickedOn) {
      clickedOn = false;
      //disease = new DiseaseSpread(mouseX,mouseY,area);
      //startInfection = true;
      disease.spread();
    }
  }

  void virus(int first) {
    System.out.println(first);
  }
}