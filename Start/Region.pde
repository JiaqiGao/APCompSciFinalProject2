class Region {
  String name;
  int[] colorCode;
  int startTime; 
  int population, popDead, popInfected;
  int growthFactor;
  ArrayList<Coord> area = new ArrayList<Coord>();
  ArrayList pixel = new ArrayList();
  boolean hovering = false;
  boolean clickedOn = false;
  boolean close = false;
  PImage window;
  boolean startInfection = false;
  //number of location infected
  int infectionArea;
  //population per pixel
  int perSquare;
  //total amount of HP for the country
  long totalHP, HP;

  //timer for when to increase pop
  int lastTime;
  int now;


  //Contructor sets variable to intial value
  public Region(String name, int population, int[] colorCode) {
    this.name = name;
    this.population = population;
    popDead = 0;
    popInfected = 0;
    //testing initial value, set HP for each person to be 10
    totalHP = population*1;
    HP = population*1;
    //println(name+" "+population+", totalHP:"+totalHP+", HP:"+HP);
    this.colorCode = colorCode;
    window = loadImage("window.png");
    window.resize(400, 300);
    lastTime = timer.getTime();
    //load coordinates into ArrayList if satisfied colorCode requirement
    for (int i = 0; i<pixels.length; i++) {
      for (int x = 0; x < colorCode.length; x++) { 
        if (pixels[i] == colorCode[x]) {
          area.add(new Coord(i%width, i/width));
          infectable.add(new Coord(i%width, i/width));
          pixel.add(i);
        }
      }
    }

    //random population growth
    growthFactor = (int)(Math.random()*0.0001);
  }

  //return name
  public String getName() {
    return name;
  }

  //check if a coord object is in area arraylist
  public boolean has(Coord pair) {
    for (Coord current : area) {
      if (current.equals(pair)) {
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
    Coord current = new Coord(mouseX, mouseY);
    if (has(current)) {
      hovering = true;
      currentCountry = getName();
      return currentCountry +" infection area "+infectionArea;
    } else {
      hovering = false;
      currentCountry = "";
    }
    return "";
  }

  //create a window when mouse click on the area
  void openWindow() {
    //if(startInfection){
    //  //startInfection = false;
    //}else 
    if (clickedOn && !select) {

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
    //String newAlive = commify(Integer.toString(popAlive));
    String newDead = commify(Integer.toString(popDead));
    fill(0, 102, 153);
    textSize(20);
    text(name, 475-(2.5*name.length()), 210); 
    textSize(16);
    text("Population: " + newPop, 330, 210+(1*linespacing));
    text("Population Infected: " + newInfect, 330, 210+(2*linespacing));
    //text("Population Alive: " + newAlive, 330, 210+(3*linespacing));
    text("Population Dead: " + newDead, 330, 210+(3*linespacing));
    //if (first) {

    if (openingGift || totalInfect >= diseaseCost) {
      fill(225, 60, 49);
      rect(437, 398, 100, 35);
      fill(255, 255, 255);
      textSize(15);
      text("INFECT", 463, 420);
      infectButton = true;
    } else {
      fill(203, 203, 203);
      rect(439, 398, 120, 35);
      fill(0, 0, 0);
      textSize(10);
      text("NOT ENOUGH POINTS", 445, 420);
      infectButton = false;
    }
  }

  //void spreadVirus(int time) {
  //  if (startInfection) {
  //    startTime = time;

  //    if ((int)(Math.random()*popInfected)+1 > (int)(Math.random()*popInfected)) {
  //      int selection1 = (int)Math.random()*popInfected+1;
  //      popInfected += selection1;
  //    }
  //    if (time%5 == 0 && popInfected > 0) {
  //      int selection2 = (int)Math.random()*popInfected;
  //      popDead += selection2;
  //      popAlive -= selection2;
  //      popInfected -= selection2;
  //    }
  //  }
  //}

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

  //update the change in population 
  void populationChange() {
    now = timer.getTime();
    if (population <= 0) {
      population = 0;
      HP = 0;
      totalHP = 0;
    } else if (now - lastTime >= 2 && population > 0) {
        lastTime = now;
        // population = (int)(population * Math.pow(E,(growthFactor*timer.getTime()/1000)));
        int selection = (int)(Math.random()*3);
        population += selection;
        HP += selection;
        totalHP += selection;
        //popAlive += selection;
      }
    //update population per pixel
    perSquare = population/area.size();

    //update how many people are infected
    popInfected = perSquare * infectionArea;

    //update how many people still alive
    //each person has 10 HP for now
    //popAlive = totalHP / 10;

    //update how many people dead by subtraction
    popDead = (int)((HP - totalHP)/1);
    //population -= popDead;
    population = (int)(totalHP/1);
    if (hovering) {
      text(population, 100, 250);
    }
  }
}