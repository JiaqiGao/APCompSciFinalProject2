class Time {

  //factor which determines how much faster
  //the time in the game pass
  int factor = 1;

  //keep track of milliseconds passed in actual life
  int start;
  int end;

  //time in seconds in the game
  int time;

  //time in the game
  int minute;
  int hour;
  int day = 1;
  int month = 1;
  int year = 2016;

  //see if clock is running
  boolean running = false;

  void runTime() {
    start = millis();
    running = true;
  }

  void stopTime() {
    end = millis(); 
    running = false;
  }

  //return time in milliseconds
  int getMilli() {
    if (running) {
      return millis() - start;
    } else {
      return end - start;
    }
  }

  //update actual time passed by converting millisecond to second
  //faster/slower depending on the factor
  int getTime() {
    time = getMilli()/1000 * factor;
    return (int)time;
  }

  void convert() {
    getTime();
    minute = (time/60) % 60;
    hour = (time/(60*60)) % 24;
  }

  void showTime() {
    fill(0);
    textSize(20);
    String day = "";
    if(getTime() == 1){
     day = "1st"; 
    }else if(getTime() == 2){
     day = "2nd"; 
    }else if(getTime() == 3){
     day = "3rd"; 
    }else{
     day = getTime()+"th"; 
    }
    text(day+" Day", 60, 30);
  }
}