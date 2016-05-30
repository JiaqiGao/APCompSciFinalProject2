class DiseaseSpread {

  ArrayList<Coord> infected = new ArrayList<Coord>();
  ArrayList<Coord> infectable = new ArrayList<Coord>();
  boolean infect; 

  public DiseaseSpread() {
    for (Region place : world) {
      infectable.addAll(place.area);
    }
    infect = false;
  }

  void run() {
    if (infect) {
      ArrayList<Coord> newlyInfected = new ArrayList<Coord>();
      Coord current = new Coord(mouseX, mouseY);
      infected.add(current);
      newlyInfected.add(current);
      spread(newlyInfected);
      infect = false;
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
        if (!has(next)){
          newlyInfected.add(next);
          infected.add(next);
        }
      }
    }
    return newlyInfected;
  }

  //check if a coord object is in area arraylist
  public boolean has(Coord pair) {
    for (Coord current : infected) {
      if (current.equals(pair)) {
        return true;
      }
    }
    return false;
  }
  
  void show(){
    text(infected.size(),100,400);
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