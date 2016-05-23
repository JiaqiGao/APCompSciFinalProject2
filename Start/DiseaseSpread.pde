class DiseaseSpread {

  int[] startPoint = new int[2];
  ArrayList<Coord> infectedArea = new ArrayList<Coord>();
  int timePassing; 
  
  public DiseaseSpread(int x, int y) {
    startPoint[0] = x;
    startPoint[1] = y;
    timePassing = 0;
    infectedArea.add(new Coord(x,y));
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