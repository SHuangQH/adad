class Bolt {
  Bolt() {
    
  }
  
  void strike() {
    // 1. check which area the lightning should appear
      // can restrict it to a specific third
      // or base it entirely on the position of a specific joint 
      
    // 2. draw the lightning bolt
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
    
    // 3. figure out if there should be a fork and whether and draw it 
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

  void fork(float chance) {
    chance = 0.01;
    if (random(0,1) < chance) {
      float newTheta = theta;
      newTheta += randomSign()*random(minDTheta, maxDTheta);
      if(theta>maxTheta)
        theta = maxTheta;
      if(theta<-maxTheta)
        theta = -maxTheta;
  //        nForks++;
      (new lightningBolt(x2, y2, lineWidth, newTheta, straightJumpMin, straightJumpMax,boltColor)).draw();
      //it draws the whole limb before continuing.
    }
  }
}
