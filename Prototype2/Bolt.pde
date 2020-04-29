class Bolt {
  float x0, x1, x2, y0, y1, y2;
  float lineWidth, lineWidth2, theta, min, max, jump;
  color myColour;
  
  // lightning bolt constructor
  Bolt(float a1, float a2, float w, float t, float minn, float maxx, color c) {
    
    // positions of important points in the lightning bolt
    x0 = a1;
    x1 = a1;
    x2 = a1;
    
    y0 = a2;
    y1 = a2;
    y2 = a2;
    
    theta = t;
    min = minn;
    max = maxx;
    lineWidth = w;
    lineWidth2 = w;
    
    myColour = c;
    
    jump = random(min, max);
  }
  
  void draw() {
      while (y2 < height && (x2 > 0 && x2 < width)) {
        strokeWeight(1);
        
        theta += randomSign()*random(minDTheta, maxDTheta);
        if (theta > maxTheta) {
          theta = maxTheta;
        }
        
        if (theta < -maxTheta) {
          theta = -maxTheta;
        }
        
        jump = random(min, max);
        x2 = x1-jump*cos(theta-HALF_PI);
        y2 = y1-jump*sin(theta-HALF_PI);
        
        // make the line width relative to the size, position of the line/fork
        lineWidth = map(y2, height, y0, 1, lineWidth2);
        if (lineWidth < 0) {
          lineWidth = 0;
        }
        
        // draw the line
        stroke(myColour);
        strokeWeight(lineWidth);
        line(x1,y1,x2,y2);
        // reposition coordinates to the end of the line
        x1=x2;
        y1=y2;
        
        // decide if a fork in the bolt is needed
        // 10% chance of a fork happening
        if (random(0,1) < childGenOdds) {
          float newTheta = theta;
          newTheta += randomSign()*random(minDTheta, maxDTheta);
          if (theta > maxTheta) theta = maxTheta;
          if (theta < -maxTheta) theta = -maxTheta;
          // create a new line in the lightning bolt
          (new Bolt(x2, y2, lineWidth, newTheta, min, max, boltColour)).draw();;
        }
      
    }
    
  }
  
}
