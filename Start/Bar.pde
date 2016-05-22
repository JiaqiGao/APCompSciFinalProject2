class Bar{
  int w, l, xcor, ycor;
  String name;
  
  public Bar(int xcor, int ycor, String name){
    this.xcor = xcor;
    this.ycor = ycor;
    this.name = name;
    w = 120;
    l = 25;
    createBar();
  }
  
  void createBar(){
    fill(0, 0, 0);
    stroke(0, 0, 0);
    rect(xcor,ycor, w, l);
    textSize(10);
    text(name, xcor, ycor+20);
  }
  
}