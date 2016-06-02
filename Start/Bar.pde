class Bar{
  int xcor, ycor, full, w, l;
  String name;
  PImage window;
  PImage check;
  boolean mutationWindow = false; 
  boolean visible;
  boolean[][] resistances = new boolean[3][5];
  boolean[] checks = new boolean[4];
  
  public Bar(int xcor, int ycor, String name, int w, int l, boolean visible){
    this.xcor = xcor;
    this.ycor = ycor;
    this.name = name;
    this.w = w;
    this.l = l;
    this.visible = visible;
    full = 110;
    window = loadImage("window.png");
    window.resize(400, 300);
    check = loadImage("check.png");
    check.resize(25, 25);
    /*
    if(name.equals("Resistances")){
      for(int i=0; i<resistances.length; i++){
        for(int j=0; j<resistances[0].length; j++){
          resistances[i][j] = false; 
        }
      }
    }*/
    
  }
  
  void createButton(){
    if(visible){
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
      int ts;
      if(name == "Resistances" || name == "Symptoms"){
        textSize(18);
        ts = 18;
      }else{
        textSize(15);
        ts = 15;
      }
      fill(37, 14, 206, 150);
      text(name, xcor+(l/2)-(name.length()/2), ycor+(1.3*ts));
      mutationInfo(ts);
    }
  }
  
  void mutationInfo(int ts){
    if(visible){
      if(mutationWindow){
       image(window, 300, 150);
       windowinfo(ts);
      }
    }
  }
  
  void windowinfo(int ts){
    if(visible){
      int linespacing = 50;
      textSize(30);
      text(name, 300+(200-((ts*name.length())/2)), 236);
      if(name.equals("Symptoms")){
        textSize(18);
        int checkspacing = 36;
        //air
        fill(60,60,90);
        text("Coughing", 374, 279);
        text("Fever", 374, 279+checkspacing);
        text("Paralysis", 374, 279+(2*checkspacing));
        text("Amnesia", 374, 279+(3*checkspacing));
        noFill();
        stroke(60, 60, 90);
        rect(344, 264, 18, 18);
        if(checks[0]){
          image(check, 344, 258);
        }
        
        rect(344, 264+checkspacing, 18, 18);
        if(checks[1]){
          image(check, 344, 258+checkspacing);
        }
        
        rect(344, 264+(2*checkspacing), 18, 18);
        if(checks[2]){
          image(check, 344, 258+(2*checkspacing));
        }
        
        rect(344, 264+(3*checkspacing), 18, 18);
        if(checks[3]){
          image(check, 344, 258+(3*checkspacing));
        }
      }
      
      if(name.equals("Resistances")){
        textSize(18);
        int rectspacing = 20;
        //air
        fill(60,60,90);
        text("Air", 334, 279);
        fill(210, 210, 210);
        if(resistances[0][0]){
          fill(110, 120, 190);
        }
        rect(409+(0*rectspacing), 257, 10, 30);
        fill(210, 210, 210);
        if(resistances[0][1]){
          fill(110, 120, 190);
        }
        rect(409+(1*rectspacing), 257, 10, 30);
        fill(210, 210, 210);
        if(resistances[0][2]){
          fill(110, 120, 190);
        }
        rect(409+(2*rectspacing), 257, 10, 30);
        fill(210, 210, 210);
        if(resistances[0][3]){
          fill(110, 120, 190);
        }
        rect(409+(3*rectspacing), 257, 10, 30);
        fill(210, 210, 210);
        if(resistances[0][4]){
          fill(110, 120, 190);
        }
        rect(409+(4*rectspacing), 257, 10, 30);
        //water
        fill(60,60,160);
        text("Water", 334, 279+linespacing);
        fill(210, 210, 210);
        if(resistances[1][0]){
          fill(110, 120, 190);
        }
        rect(409+(0*rectspacing), 257+linespacing, 10, 30);
        fill(210, 210, 210);
        if(resistances[1][1]){
          fill(110, 120, 190);
        }
        rect(409+(1*rectspacing), 257+linespacing, 10, 30);
        fill(210, 210, 210);
        if(resistances[1][2]){
          fill(110, 120, 190);
        }
        rect(409+(2*rectspacing), 257+linespacing, 10, 30);
        fill(210, 210, 210);
        if(resistances[1][3]){
          fill(110, 120, 190);
        }
        rect(409+(3*rectspacing), 257+linespacing, 10, 30);
        fill(210, 210, 210);
        if(resistances[1][4]){
          fill(110, 120, 190);
        }
        rect(409+(4*rectspacing), 257+linespacing, 10, 30);
        //heat
        fill(160,60,60);
        text("Heat", 334, 279+(2*linespacing));
        fill(210, 210, 210);
        if(resistances[2][0]){
          fill(110, 120, 190);
        }
        rect(409+(0*rectspacing), 257+(2*linespacing), 10, 30);
        fill(210, 210, 210);
        if(resistances[2][1]){
          fill(110, 120, 190);
        }
        rect(409+(1*rectspacing), 257+(2*linespacing), 10, 30);
        fill(210, 210, 210);
        if(resistances[2][2]){
          fill(110, 120, 190);
        }
        rect(409+(2*rectspacing), 257+(2*linespacing), 10, 30);
        fill(210, 210, 210);
        if(resistances[2][3]){
          fill(110, 120, 190);
        }
        rect(409+(3*rectspacing), 257+(2*linespacing), 10, 30);
        fill(210, 210, 210);
        if(resistances[2][4]){
          fill(110, 120, 190);
        }
        rect(409+(4*rectspacing), 257+(2*linespacing), 10, 30);
      }
    }
  }
  
  void openWindow() {
    if(visible){
      image(window, 300, 150);
      //windowinfo();
    }
    //if mouse over close button, "highlight" the button
    /*
    if (mouseX >= 675 && mouseX <= 693 &&
      mouseY >= 154 && mouseY <= 170) {
      fill(37, 140, 206, 150);
      noStroke();
      rect(675, 154, 18, 17);
    }
    */
    
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