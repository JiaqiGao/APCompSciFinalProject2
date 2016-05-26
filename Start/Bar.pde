class Bar{
  int xcor, ycor, full, w, l;
  String name;
  PImage window;
  boolean mutationWindow = false; 
  
  public Bar(int xcor, int ycor, String name, int w, int l){
    this.xcor = xcor;
    this.ycor = ycor;
    this.name = name;
    this.w = w;
    this.l = l;
    full = 110;
    window = loadImage("window.png");
    window.resize(400, 300);
    mutationInfo();
  }
  
  void createButton(){
    if (mouseX >= xcor && mouseX <= xcor+w &&
          mouseY >= ycor && mouseY <= ycor+l) {
          fill(37, 140, 206, 150);
          noStroke();
          rect(xcor, ycor, w, l);
    }else{
      fill(197, 245, 135);
      rect(xcor,ycor, w, l);
      noStroke();
    }
    textSize(15);
    fill(37, 14, 206, 150);
    text(name, xcor+7, ycor+20);
  }
  
  void mutationInfo(){
   if (mouseX >= xcor && mouseX <= xcor+w &&
          mouseY >= ycor && mouseY <= ycor+l) {
       mutationWindow = true;
    }
    if(mutationWindow){
      openWindow();
    }
  }
  
  void windowinfo(){
    
  }
  
  void openWindow() {
    image(window, 300, 150);
    windowinfo();
    //if mouse over close button, "highlight" the button
    if (mouseX >= 675 && mouseX <= 693 &&
      mouseY >= 154 && mouseY <= 170) {
      fill(37, 140, 206, 150);
      noStroke();
      rect(675, 154, 18, 17);
    }
    
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