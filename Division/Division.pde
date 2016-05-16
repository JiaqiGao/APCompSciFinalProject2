PImage img;


// The statements in the setup() function 
// execute once when the program begins
void setup() {
  size(640, 360);  // Size must be the first statement
  //stroke(255);     // Set line drawing color to white
  frameRate(30);
  img = loadImage("worldmap.png");
  image(img, 0, 0);
  img.resize(640, 360);
  image(img, 0, 0);
}
// The statements in draw() are executed until the 
// program is stopped. Each statement is executed in 
// sequence and after the last line is read, the first 
// line is executed again.
void draw() { 
  background(img);   // Clear the screen with a black background
  /*
  y = y - 1; 
  if (y < 0) { 
    y = height; 
  } 
  line(0, y, width, y);  
  */
} 