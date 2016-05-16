class Coord{
 int x;
 int y;
 
 public Coord(int x, int y){
  this.x = x;
  this.y = y;
 }
 
 public int getX(){
  return x; 
 }
 
 public int getY(){
  return y; 
 }
}


  PImage map;
  
  void setup(){
    size(800,600);
   map = loadImage("worldmap.png");
   
  }
  
  
  void draw(){
   image(map, 0, 0, 800, 600);
   fill(0);
   text(get(mouseX,mouseY),100,120);
  }
  