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
  ArrayList<Coord> NorthAmerica;  
  void setup(){
    size(800,600);
   map = loadImage("worldmap.png");
   map.loadPixels();
   section();
  }
  
  
  void draw(){
   image(map, 0, 0, 800, 600);
   fill(0);
   text(get(mouseX,mouseY),100,120);
   //text(mouseY*width+mouseX,100,140);
   text(map.pixels[width*mouseY+mouseX],100,160);
   for(int i = 0; i < NorthAmerica.size(); i++){
     if(NorthAmerica.get(i).getX() == mouseX &&
     NorthAmerica.get(i).getY() == mouseY){
       println(true);
     }
   }
  }
  
  
  
  void section(){
   for(int i = 0; i<map.pixels.length; i++){
    if(map.pixels[i] == -16733696){
     NorthAmerica.add(new Coord(i/800,i%800)); 
    }
   }
  }