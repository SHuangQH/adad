// inspired by: https://www.openprocessing.org/sketch/816655

ArrayList<PVector> points;

void setup() {
  size(600, 600);
  background(0);
}

void draw() {
  background(0);
  frameRate(6);
  
  //if (random(100) < 10) {
    PVector p1 = new PVector(random(width), 0);
    PVector p2 = new PVector(random(width), height);
    
    points = randomPoints(p1.x, p1.y, p2.x, p2.y, 0.25);
    points.add(p2);
    
    stroke(64, 46, 255, 32);
    strokeWeight(16);
    drawChaoticLine(points);
    
    stroke(64, 64, 255, 32);
    strokeWeight(8);
    drawChaoticLine(points);
    
    stroke(128, 128, 255, 32);
    strokeWeight(4);
    drawChaoticLine(points);
    
    stroke(255, 255, 255, 255);
    strokeWeight(2);
    drawChaoticLine(points);
  //}
}
  
ArrayList<PVector> randomPoints(float x1, float y1, float x2, float y2, float chaos) {
  ArrayList<PVector> ptlist = new ArrayList<PVector>();  
  float d_x = x2-x1;
  float d_y = y2-y1;
  float mag = sqrt(d_x*d_x + d_y*d_y);
  if (mag > 10) {
    float ch = randomGaussian()*chaos/2.0;  // randomGaussian seems to give a better result but is a bit slower
    //float ch = random(-chaos, chaos);
    
    // Take a random point on the line perpendicular to the given segment and 
    // passing through the midpoint of the segment
    float xc = ((x1+x2)/2) - d_y*ch;
    float yc = ((y1+y2)/2) + d_x*ch;
    ptlist.addAll(randomPoints(x1, y1, xc, yc, 0.25));
    ptlist.addAll(randomPoints(xc, yc, x2, y2, 0.25));
    return ptlist;
  } else {
    line(x1, y1, x2, y2);
    ptlist.add(new PVector(x1, y1));
    return ptlist;
  }
}

void drawChaoticLine(ArrayList<PVector> points) {
  for (int i=0; i<points.size()-1; i++) {
    PVector p1 = points.get(i);
    PVector p2 = points.get(i+1);
    line(p1.x, p1.y, p2.x, p2.y);
  }
}
