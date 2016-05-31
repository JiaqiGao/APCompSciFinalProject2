class DiseaseSpread {

  //ArrayList<Coord> infected = new ArrayList<Coord>();
  // ArrayList<Coord> infectable = new ArrayList<Coord>();
  boolean infect; 
  ArrayList<Coord> waitingList = new ArrayList<Coord>();
  int lastTime;
  int now;

  public DiseaseSpread() {
    // infect = false;
    waitingList.add(new Coord(mouseX, mouseY));
    lastTime = timer.getTime();
  }

  //void run() {
  //  Coord current = new Coord(mouseX, mouseY);
  //  ArrayList<Coord> newlyInfected = new ArrayList<Coord>();
  //  String c = ""+has(infectable, current)+", "+lastTime+","+now;
  //  text(c, 100, 430);
  //  //infect
  //  if ((!has(infected, current)) && has(infectable, current) ) {
  //    infected.add(current);
  //    newlyInfected.add(current);
  //    waitingList = spread(newlyInfected);
  //  }
  //  if (now - lastTime >= 2) {
  //    lastTime = now;
  //    waitingList = spread(waitingList);
  //    // hasNew = true;
  //  }
  // // infect = false;
  //  for (Coord pair : infected) {
  //    map.loadPixels();
  //    map.pixels[pair.getY() * width + pair.getX()] = 0;
  //    map.updatePixels();
  //  }
  //}


  void spread() {
    map.loadPixels();
    now = timer.getTime();
    int[] shift = {-1, 0, 1, 0, 0, -1, 0, 1};
    if (now - lastTime >= 2) {
      lastTime = now;
      ArrayList<Coord> newlyInfected = new ArrayList<Coord>();
      for (Coord pair : waitingList) {
        if (!has(infected, pair) && has(infectable, pair)) {
          infected.add(pair);
          map.pixels[pair.getY()*width + pair.getX()] = 255;
          for (int i = 0; i < shift.length/2; i++) {
            int x = pair.getX() + shift[2*i];
            int y = pair.getY() + shift[2*i + 1];
            Coord next = new Coord(x, y);
            newlyInfected.add(next);
          }
        }
      }
      waitingList = newlyInfected;
    }
    map.updatePixels();
  }

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
}