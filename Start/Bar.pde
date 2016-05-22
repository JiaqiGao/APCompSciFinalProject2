class Bar{
  int w, l, xcor, ycor, full;
  String name;
  
  public Bar(int xcor, int ycor, String name){
    this.xcor = xcor;
    this.ycor = ycor;
    this.name = name;
    w = 120;
    l = 25;
    full = 110;
  }
  
  void createBar(){
    noFill();
    stroke(0, 0, 0);
    rect(xcor,ycor, w, l);
    if(deadCalc()>10){
      fill(197, 245, 135);
    }else{
      fill(218, 255, 168);
    }
    if(deadCalc()>30){
      fill(192, 250, 115);
    }
    if(deadCalc()>50){
      fill(172, 243, 80);
    }
    if(deadCalc()>75){
      fill(142, 2016, 44);
    }
    if(deadCalc()>90){
      fill(125, 195, 34);
    }
    noStroke();
    rect(xcor+5,ycor+5, deadCalc(), l-10);
    textSize(10);
    fill(100, 145, 41);
    text(name, xcor, ycor+37);
  }
  
  //calculates progress and changes length of progress bar
  float deadCalc(){
    int dead = 0;
    int infected = 0;
    int worldPop = 0;
    for(Region r : world){
      dead += r.popDead;
      infected += r.popInfected;
      worldPop += r.population; 
    }
    //test
    dead = 10000;
    infected = 152222222;
    return (float)((float)(dead + (float)(infected/2))/worldPop)*full;
  }
  
}