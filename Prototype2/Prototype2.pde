// ADAD3400 Assessment 3

/* Lightning code is inspired by: 
     Attribute: "Lightning Storm" by Esteban Hufstedler
     http://www.openprocessing.org/sketch/2924 
     Licensed under Creative Commons Attribution
*/

// KINECT
import KinectPV2.KJoint;
import KinectPV2.*;

KinectPV2 Kinect = new KinectPV2(this);

// SOUND
import processing.sound.*;

WhiteNoise noise;
SoundFile thunderstorm;
SoundFile whitenoise;

Audio audio = new Audio();

// count joints
int jointCount = 0;

// LIGHTNING
PVector pos;

// bolt properties
float maxDTheta = PI/10;
float minDTheta = PI/20;
float maxTheta = PI/2;
float childGenOdds = .01; // creating forks in a bolt
float minBoltWidth = 3;
float maxBoltWidth = 10;
float minJumpLength = 1;
float maxJumpLength = 20;

// colour
color boltColour = color(360, 360, 360); // default set to white
color skyColour = color(0, 0, 0, 30); // default to slightly transparent black

// timing
boolean fading = true; 
float maxTimeBetweenStrikes = 2000; // milliseconds
float lastStrike = 0;
float nextStrikeInNms = 0;

Bolt bolt = new Bolt(random(0,width),0, random(minBoltWidth, maxBoltWidth), 0, minJumpLength, maxJumpLength, boltColour);


void setup() {
  size(1920, 1080, P3D);
  
  // set up kinect
  Kinect.enableSkeletonColorMap(true);
  Kinect.enableColorImg(true);
  Kinect.init();
  
  // set up sound files
  thunderstorm = new SoundFile(this, "thunderstorm.aiff");
  whitenoise = new SoundFile(this, "whitenoise.aiff");
  noise = new WhiteNoise(this);
  
  colorMode(HSB, 100);
  smooth();
  noFill();
  background(skyColour);
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
      rectMode(CORNER);
      rect(0, 0, width, height);
      noFill();
    }
  }
  
  jointCount = 0;
  
  // boundary to represent the cloud or bed
  rectMode(CENTER);
  stroke(255);
  strokeWeight(10);
  noFill();
  rect(width/2, height/2, width/3, height);
  
  // kinect 
  ArrayList<KSkeleton> skeletonArray =  Kinect.getSkeletonColorMap();

  //individual JOINTS
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();
      
      color col  = skeleton.getIndexColor();
      fill(col);
      stroke(col);
      drawBody(joints);
    }
  }
  
}

//DRAW BODY
void drawBody(KJoint[] joints) {
  drawBone(joints, KinectPV2.JointType_Head, KinectPV2.JointType_Neck);
  drawBone(joints, KinectPV2.JointType_Neck, KinectPV2.JointType_SpineShoulder);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid);
  drawBone(joints, KinectPV2.JointType_SpineMid, KinectPV2.JointType_SpineBase);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderRight);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderLeft);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipRight);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipLeft);

  // Right Arm
  drawBone(joints, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight);
  drawBone(joints, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_HandRight);
  drawBone(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandTipRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_ThumbRight);

  // Left Arm
  drawBone(joints, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft);
  drawBone(joints, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_HandLeft);
  drawBone(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_HandTipLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_ThumbLeft);

  // Right Leg
  drawBone(joints, KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeRight);
  drawBone(joints, KinectPV2.JointType_KneeRight, KinectPV2.JointType_AnkleRight);
  drawBone(joints, KinectPV2.JointType_AnkleRight, KinectPV2.JointType_FootRight);

  // Left Leg
  drawBone(joints, KinectPV2.JointType_HipLeft, KinectPV2.JointType_KneeLeft);
  drawBone(joints, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_AnkleLeft);
  drawBone(joints, KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_FootLeft);

  drawJoint(joints, KinectPV2.JointType_HandTipLeft);
  drawJoint(joints, KinectPV2.JointType_HandTipRight);
  drawJoint(joints, KinectPV2.JointType_FootLeft);
  drawJoint(joints, KinectPV2.JointType_FootRight);

  drawJoint(joints, KinectPV2.JointType_Head);
}

//draw joint
void drawJoint(KJoint[] joints, int jointType) {
  
  pushMatrix();
  translate(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());

  if ((joints[jointType].getX() > 0 && joints[jointType].getX() < width/3) || (joints[jointType].getX() < width && joints[jointType].getX() > 2*width/3)) {
    
    //// background colour becomes darker
    //if (bg > 0) {
    //  bg -= 1;
    //}
    
    audio.thunder(); // play thunder audio if no one is on the cloud
  } else {
    jointCount++;
    
    //// background colour becomes lighter
    //if (bg < 255) {
    //  bg += 1;
    //}
    
    audio.whitenoise(); // play white noise audio if someone is on the cloud
  }
  
  ellipse(0, 0, 25, 25);
  popMatrix();
}

//draw bone
void drawBone(KJoint[] joints, int jointType1, int jointType2) {
  pushMatrix();
  translate(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
  line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ(), joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
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
