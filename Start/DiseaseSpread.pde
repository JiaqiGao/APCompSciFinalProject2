class DiseaseSpread {

  ArrayList<Coord> infected = new ArrayList<Coord>();
  // ArrayList<Coord> infectable = new ArrayList<Coord>();
  boolean infect; 
  ArrayList<Coord> waitingList = new ArrayList<Coord>();
  public DiseaseSpread() {
    infect = false;
  }

  void run() {
    Coord current = new Coord(mouseX, mouseY);
    ArrayList<Coord> newlyInfected = new ArrayList<Coord>();
    //println("new newlyInfected arraylist"+newlyInfected.size());
    //int now = timer.getTime();
    String c = ""+has(infectable, current)+", "+lastTime+","+now;
    text(c, 100, 430);
    //boolean hasNew = false;
    if (infect && (!has(infected, current)) && has(infectable, current) ) {
      infected.add(current);
      newlyInfected.add(current);
      waitingList = spread(newlyInfected);
      //println("recycled newlyInfected arraylist"+newlyInfected.size());
    }
    if (now - lastTime >= 2) {
      lastTime = now;
      waitingList = spread(waitingList);
      // hasNew = true;
    }
    infect = false;
    for(Coord pair : infected){
     map.loadPixels();
     map.pixels[pair.getY() * width + pair.getX()] = 0;
     map.updatePixels();
    }
  }


  ArrayList<Coord> spread(ArrayList<Coord> origin) {
    int[] shift = {-1, 0, 1, 0, 0, -1, 0, 1};
    ArrayList<Coord> newlyInfected = new ArrayList<Coord>();
    for (Coord pair : origin) {
      for (int i = 0; i < shift.length/2; i++) {
        int x = pair.getX() + shift[2*i];
        int y = pair.getY() + shift[2*i + 1];
        Coord next = new Coord(x, y);
        if (!has(infected, next) && has(infectable,next)) {
          newlyInfected.add(next);
          infected.add(next);
        }
      }
    }
    return newlyInfected;
  }

  //void multiply(ArrayList<Coord> origin) {
  //  ArrayList<Coord> newlyInfected = new ArrayList<Coord>();
  //  newlyInfected = spread(origin);
  //  if (timer.getTime() % 60 == 0) {
  //    spread(newlyInfected);
  //  }
  //}

  //check if a coord object is in area arraylist
  public boolean has(ArrayList<Coord> souce, Coord pair) {
    for (Coord current : souce) {
      if (current.equals(pair)) {
        return true;
      }
    }
    return false;
  }

  void show() {
    text(infected.size(), 100, 400);
  }
  //public DiseaseSpread(int x, int y, ArrayList<Coord> area) {
  //  //startPoint[0] = x;
  //  //startPoint[1] = y;
  //  countryCoord = area;
  //  Coord startPoint = new Coord(x, y);
  //  infectedArea.add(startPoint);
  //  //timePassing = 0;
  //}

  //void showInfect() {
  //  fill(0);
  //  textSize(15);
  //  text(infectedArea.size(), 550, 100);
  //}

  //void spread() {
  //  int fate = (int)Math.random()*countryCoord.size();
  //  Coord toAdd = countryCoord.get(fate);
  ////<<<<<<< HEAD
  //  //if (!infectedArea.contains(toAdd)) {
  //  //  infectedArea.add(toAdd);
  //  //}
  //  boolean contains = false;
  //  for(Coord infected : infectedArea){
  //    contains = infected.equals(toAdd);
  //  }
  //  if(!contains){
  //   infectedArea.add(toAdd); 
  ////=======
  ////    if (!infectedArea.contains(toAdd)) {
  ////      infectedArea.add(toAdd);
  ////>>>>>>> 7804ca2ce15a9f185ed7eb3b369fb85d436c562c
  //  }
  //  //for (int i = 0; i < infectedArea.size()-1; i++) {
  //  //  spread(infectedArea.get(i).getX(), infectedArea.get(i).getY());
  //  //}
  //}

  //void spread(int x, int y) {
  //  if ((timer.getMilli() / 1000) % 10 == 0) {
  //    for (int a = -1; a < 2; a++) {
  //      for (int b = -1; b < 2; b++) {
  //        Coord toAdd = new Coord(x+a, y+b);
  //        if (!(infectedArea.contains(toAdd)) &&
  //          countryCoord.contains(toAdd)) {
  //          infectedArea.add(toAdd);
  //          // spread(x+a,y+b);
  //        }
  //      }
  //    }
  //  }
  //}

  //void spread(){
  //  loadPixels();
  //  timePassing = timer.getMilli();
  //  if(timePassing % 100 == 0){
  //   for(Coord pair : infectedArea){
  //    pixels[pair.getX()*width+pair.getY()] = pixels[pair.getX()*width+pair.getY()]+10; 
  //   }
  //  }
  //}
}