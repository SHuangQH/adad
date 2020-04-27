class Bolt {
  //PVector p1, p2, p3;
  float x0, x1, x2, y0, y1, y2;
  float lineWidth, lineWidth2, theta, min, max, jump;
  color myColour;
  
  //Bolt(PVector p, float t, float minn, float maxx, float w) {
    Bolt(float a1, float a2, float t, float minn, float maxx, float w, color c) {
    //p1 = new PVector(p.x, p.y);
    //p2 = new PVector(p.x, p.y);
    //p3 = new PVector(p.x, p.y);
    
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
    //while (p3.y < height && (p3.x > 0 && p3.x < width)) {
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
      //p3.set(p2.x - jump*cos(theta - HALF_PI), p2.y - jump*sin(theta - HALF_PI));
      //x3 = x2 - jump*cos(theta - HALF_PI);
      //y3 = y2 - jump*sin(theta - HALF_PI);
      //p3.x = p2.x - jump*cos(theta - HALF_PI);
      //p3.y = p2.y - jump*sin(theta - HALF_PI);
      //println(p3.x, p3.y);
      x2 = x1-jump*cos(theta-HALF_PI);
      y2 = y1-jump*sin(theta-HALF_PI);
      
      //lineWidth = map(p3.y, height, p1.y, 1, lineWidth2);
      //lineWidth = map(y3, height, y1, 1, lineWidth2);
      lineWidth = map(y2, height, y0, 1, lineWidth2);
      if (lineWidth < 0) {
        lineWidth = 0;
      }
      
      stroke(myColour);
      strokeWeight(lineWidth);
      //line(p2.x, p2.y, p3.x, p3.y);
      //p2.set(p3.x, p3.y);
      //line(x2, y2, x3, y3);
      //x2 = x3;
      //y2 = y3;
      //p2.x = p3.x;
      //p2.y = p3.y;
      line(x1,y1,x2,y2);
      x1=x2;
      y1=y2;
      
      if (random(0,1) < childGenOdds) {
        float newTheta = theta;
        newTheta += randomSign()*random(minDTheta, maxDTheta);
        if (theta > maxTheta) theta = maxTheta;
        if (theta < -maxTheta) theta = -maxTheta;
        //Bolt newBolt = new Bolt(p3,lineWidth, newTheta, min, max);
        //Bolt newBolt = new Bolt(x3, y3,lineWidth, newTheta, min, max, boltColour);
        (new Bolt(x2, y2, lineWidth, newTheta, min, max, boltColour)).draw();

        //newBolt.draw();
      }
      
    }
    
  }
  
}
