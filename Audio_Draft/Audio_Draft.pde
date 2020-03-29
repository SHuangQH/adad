// Draft file for demonstrating audio playing and volume adjustments in Processing
// Thunderstorm audio will play unless mouse is pressed, which would play white noise instead. 
// Mouse must move slowly from inside the window to outside otherwise MouseX and MouseY are inaccurate.

import processing.sound.*;

SoundFile thunderstorm;
SoundFile whitenoise;
Audio audio = new Audio();

void setup() {
  size(400, 600);
  background(0);
  
  thunderstorm = new SoundFile(this, "thunderstorm.aiff");
  whitenoise = new SoundFile(this, "whitenoise.aiff");
  
}

void draw() {
  //println(mouseX, mouseY);

  if ((mouseX == 0 || mouseY == 0) || (mouseX == width-1 || mouseY == height-1)) {
    audio.whitenoise();
  } else {
    audio.thunder();
  }
}
