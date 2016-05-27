class DiseaseSpread {

  //int[] startPoint = new int[2];
  ArrayList<Coord> infectedArea = new ArrayList<Coord>();
  ArrayList<Coord> countryCoord;
  // int timePassing; 

  public DiseaseSpread(ArrayList<Coord> area) {
    countryCoord = area;
  }

  public DiseaseSpread(int x, int y, ArrayList<Coord> area) {
    //startPoint[0] = x;
    //startPoint[1] = y;
    countryCoord = area;
    Coord startPoint = new Coord(x, y);
    infectedArea.add(startPoint);
    //timePassing = 0;
  }

  void showInfect() {
    fill(0);
    textSize(15);
    text(infectedArea.size(), 550, 100);
  }

  void spread() {
    int fate = (int)Math.random()*countryCoord.size();
    Coord toAdd = countryCoord.get(fate);
    if (!infectedArea.contains(toAdd)) {
      infectedArea.add(toAdd);
    }
    //for (int i = 0; i < infectedArea.size()-1; i++) {
    //  spread(infectedArea.get(i).getX(), infectedArea.get(i).getY());
    //}
  }

  void spread(int x, int y) {
    if ((timer.getMilli() / 1000) % 10 == 0) {
      for (int a = -1; a < 2; a++) {
        for (int b = -1; b < 2; b++) {
          Coord toAdd = new Coord(x+a, y+b);
          if (!(infectedArea.contains(toAdd)) &&
            countryCoord.contains(toAdd)) {
            infectedArea.add(toAdd);
            // spread(x+a,y+b);
          }
        }
      }
    }
  }

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