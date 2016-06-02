class DiseaseSpread {

  //this variable can be used later, instead of infect an area when user clicks on
  //a location, infect the location when infect is true(user clickes a button etc)
  boolean infect;
  //how much damage disease can do
  int damage;
  //waiting list for areas of next disease spread
  ArrayList<Coord> waitingList = new ArrayList<Coord>();
  //timer for when to spread disease
  int lastTime;
  int now;

  public DiseaseSpread(int damage) {
    //next position to infect in where the user picks
    waitingList.add(new Coord(mouseX, mouseY));
    lastTime = timer.getTime();
    this.damage = damage;
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
    //if time to spread
    //for now, time per round of spreading set to 2 sec
    if (now - lastTime >= 2) {
      lastTime = now;
      ArrayList<Coord> newlyInfected = new ArrayList<Coord>();
      //for each coordinate pairs in waiting list
      //check if they're on the map, and not yet infected
      for (Coord pair : waitingList) {
        if (!has(infected, pair) && has(infectable, pair)) {
          infected.add(pair);
          //change color
          map.pixels[pair.getY()*width + pair.getX()] = color(255,0,0);
          //check to see which continent the infection is
          //and add to infectionArea(number of places infected)
          //and take HealPoint off
          for(Region place : world){
           if(place.has(pair)){
            place.infectionArea++; 
            place.totalHP = place.totalHP - damage;
           }
          }
          //add location up,down,left,right to the coordinate pair
          //add to the waiting list for next round of disease spread
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
    //update to change color on map
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