class DiseaseSpread {

  int[] startPoint = new int[2];
  ArrayList<Coord> infectedArea = new ArrayList<Coord>();
  int timePassing; 
  boolean firstSelected = false;
  
  public DiseaseSpread(int x, int y) {
    startPoint[0] = x;
    startPoint[1] = y;
    timePassing = 0;
    infectedArea.add(new Coord(x,y));
  }
  
  void mouseClicked() {
    int country = 0;
    Region first = null;
    if(get(mouseX, mouseY) != -1){
      country = get(mouseX, mouseY);
      for(Region r : world){
      for(int i : r.colorCode){
          if(i == country){
            first = r;
            firstSelected = true;
          }
        }
      }
    }
    if(firstSelected){
      initiateDeathSequence(first);
    }
  }
  
  void initiateDeathSequence(Region first){
    //nothing yet
  }
  
  void spread(){
    loadPixels();
    timePassing = timer.getMilli();
    if(timePassing % 100 == 0){
     for(Coord pair : infectedArea){
      pixels[pair.getX()*width+pair.getY()] = pixels[pair.getX()*width+pair.getY()]+10; 
     }
    }
  }
  
}