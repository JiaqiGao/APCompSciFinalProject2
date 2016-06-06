class DiseaseSpread { //<>// //<>// //<>// //<>//

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
  Region startRegion;
  int initialDifficulty; //scale from 1(easy)-200(hard) it is for virus to spread base on country's medical care
  //which country the infection is in
  int effectHeat;
  int effectWater;
  int effectCold;
  Region country;

  public DiseaseSpread(int damage) {
    //next position to infect in where the user picks
    Coord pair = new Coord(mouseX,mouseY);
    startRegion = matchRegion(mouseX, mouseY);
    waitingList.add(pair);
    lastTime = timer.getTime();
    this.damage = damage;
    for(Region place : world){
     if(place.has(pair)){
      country = place; 
     }
    }
    //initial difficulty for virus to spread 
    if(startRegion.name.equals("Europe") || startRegion.name.equals("East Asia")){
      initialDifficulty = 200; 
    }else if(startRegion.name.equals("North America") || startRegion.name.equals("Greenland")){
      initialDifficulty = 140; 
    }else if(startRegion.name.equals("Asia") || startRegion.name.equals("South America")){
      initialDifficulty = 100; 
    }else{
      initialDifficulty = 60;
    }
    
    //Heat resistance effectivity (from 1-5)
    if(startRegion.name.equals("Greenland")){
      effectHeat = 1;
    }else if(startRegion.name.equals("Russia")){
      effectHeat = 2;
    }else if(startRegion.name.equals("North America") || startRegion.name.equals("Europe") || startRegion.name.equals("East Asia")){
      effectHeat = 3;
    }else if(startRegion.name.equals("South America") || startRegion.name.equals("Africa")){
      effectHeat = 4;
    }else{
      effectHeat = 5;
    }
    
    //Water resistance effectivity (1-5)
    if(startRegion.name.equals("Indonesia") || startRegion.name.equals("East Asia")){
      effectWater = 4;
    }else if(startRegion.name.equals("Australia")){
      effectWater = 3;
    }else{
      effectWater = 1;
    }
    
    //Cold resistance effectivity
    if(startRegion.name.equals("Greenland") || startRegion.name.equals("Russia")){
      effectWater = 5;
    }else if(startRegion.name.equals("Australia") || startRegion.name.equals("Indonesia")){
      effectWater = 1;
    }else if(startRegion.name.equals("South America") || startRegion.name.equals("Africa")){
      effectWater = 2;
    }else{
      effectWater = 3;
    }
  }

  void spread() {
    map.loadPixels();
    now = timer.getTime();
    //if time to spread
    //for now, time per round of spreading set to 2 sec
    if (now - lastTime >= 2 && (country.population >0) && ((int)(Math.random()*(initialDifficulty-calc("heat")-calc("cold")-calc("water")))==1)){
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
  
  int calc(String s){
    if(s.equals("cold")){
      int countC=0;
      for(int i=0; i<5; i++){
        if(bars.get(2).resistances[0][i]){
          countC++;
        }
      }
      return countC*effectCold;
    }
    
    if(s.equals("water")){
      int countW=0;
      for(int i=0; i<5; i++){
        if(bars.get(2).resistances[1][i]){
          countW++;
        }
      }
      return countW*effectWater;
    }
    
    if(s.equals("heat")){
      int countH=0;
      for(int i=0; i<5; i++){
        if(bars.get(2).resistances[2][i]){
          countH++;
        }
      }
      return countH*effectHeat;
    }  
    return 0;
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