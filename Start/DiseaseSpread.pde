class DiseaseSpread { //<>// //<>// //<>//

  //this variable can be used later, instead of infect an area when user clicks on
  //a location, infect the location when infect is true(user clickes a button etc)
  boolean infect;
  //how much damage disease can do
  int damage;
  int[] spreadColor = {125, 20, 30};
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

  void spread() {
    map.loadPixels();
    now = timer.getTime();
    //if time to spread
    //for now, time per round of spreading set to 2 sec
    if (now - lastTime >= 2) {
      lastTime = now;
      ArrayList<Coord> newlyInfected = new ArrayList<Coord>();
      //for each coordinate pairs in waiting list
      //check if they're on the map, and not yet infected
      for (Coord pair : waitingList) {
        if (!has(infected, pair) && (pair.getCountry().length() != 0) && (map.pixels[pair.getY()*width + pair.getX()] == pair.getRegion().colorCode[0])) {
         // println("able to infect "+ pair.getX()+","+pair.getY()+" on "+pair.getCountry());
          infected.add(pair);
          //change color
          map.pixels[pair.getY()*width + pair.getX()] = color(spreadColor[0], spreadColor[1], spreadColor[2]);
          if(spreadColor[0] < 240 && (int)(Math.random()*20)==3){
            spreadColor[0]++; 
            if(spreadColor[1] < 50){
              spreadColor[1]++;
              spreadColor[2]++;
            }
          }
          //add to point system
          totalInfect ++;
          //check to see which continent the infection is
          //and add to infectionArea(number of places infected)
          //and take HealPoint off
          for (Region place : world) {
            if (place.has(pair)) {
              place.infectionArea++; 
              place.totalHP = place.totalHP - damage;
            }
          }
          //add location up,down,left,right to the coordinate pair
          //add to the waiting list for next round of disease spread
          //int fate = (int)Math.random()*6;
          //for (int i = 0; i < shift.length/2; i++) {
          for (int i = 0; i < 2; i++) {
            //int x = pair.getX() + shift[2*i];
            //int y = pair.getY() + shift[2*i + 1];
            int x = pair.getX() - (int)(Math.random() * 3);
            if((int)(Math.random()*2)==1){
              x = pair.getX() + (int)(Math.random() * 3);
            }
            int y = pair.getY() - (int)(Math.random() * 3);
            
            if((int)(Math.random()*2)==1){
              y = pair.getY() + (int)(Math.random() * 3);
            }
            Coord next = new Coord(x, y);
            newlyInfected.add(next);
          }
        }
      }
      //limit the size of area to be infected
      if (newlyInfected.size() < 500) {
        waitingList = newlyInfected;
      } else {
        waitingList.clear();
        for (int i = 0; i < newlyInfected.size()/10; i++) {
          waitingList.add(newlyInfected.get(i));
        }
      }
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