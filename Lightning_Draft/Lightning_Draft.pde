// Inspired by: 
  // Attribute: "Lightning Storm" by Esteban Hufstedler
  // http://www.openprocessing.org/sketch/2924 
  // Licensed under Creative Commons Attribution

PVector pos;

float maxDTheta = PI/10;
float minDTheta = PI/20;
float maxTheta = PI/2;
float childGenOdds = .01; // creating forks in a bolt

float minBoltWidth = 3;
float maxBoltWidth = 10;

float minJumpLength = 1;
float maxJumpLength = 10;

color boltColour = color(0, 0, 99);
color skyColour = color(0, 0, 0, 20);

boolean fading = true; 
float maxTimeBetweenStrikes = 3000; // milliseconds
float lastStrike = 0;
float nextStrikeInNms = 0;

Bolt bolt;

void setup() {
  size(900, 500);
  colorMode(HSB, 100);
  smooth();
  noFill();
  background(skyColour);
  
  // bolt
  pos = new PVector(random(0, 600), 0);
  //bolt = new Bolt(pos, random(minBoltWidth, maxBoltWidth), 0, minJumpLength, maxJumpLength);
  bolt = new Bolt(random(0,width),0, random(minBoltWidth, maxBoltWidth), 0, minJumpLength, maxJumpLength, boltColour);
}

void draw() {
  // check if it is time to strike another lightning bolt
  if (millis()-lastStrike > nextStrikeInNms) { 
    // reassign time values for next strike
    lastStrike = millis();
    nextStrikeInNms = random(0, maxTimeBetweenStrikes);
    
    // draw the bolt
    //bolt = new Bolt(pos,random(minBoltWidth,maxBoltWidth),0,minJumpLength,maxJumpLength);
    bolt = new Bolt(random(0,width),0,random(minBoltWidth,maxBoltWidth),0,minJumpLength,maxJumpLength, boltColour);
    bolt.draw();
  } else {
    // if the lightning bolt should fade away then overlay a filled rectangle on top 
    if (fading) {
      noStroke();
      fill(skyColour);
      rect(0, 0, width, height);
      noFill();
    }
  }
  
}

// randomly chooses to return +1 or -1 
int randomSign() {
  float num = random(-1, 1);
  
  if (num == 0) {
    return -1;
  } else {
    return (int)(num/abs(num));
  }
}
