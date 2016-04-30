class Player {
  PVector current_location;
  PVector speed; 
  PVector d;
  float delta_r = PI/8.0;
  float direction = 0.0;
  int mode = 0;

  Player(PVector init_location) {
    current_location = init_location;
    speed = new PVector(0, -25);
  }

  void display() {
    drawPlayerMark(#F50707);
  }

  void drawPlayerMark(int c) {
    translate(current_location.x, current_location.y); //use x,y in translate as (0, 0) in the area.
    rotate(direction);

    //fill(#000000);
    //rect(-9, -12, 15, 20);
    fill(c); //fill 
    triangle(0, -12, -6, 6, 6, 6);//triangle(v.x, v.y, v.x - d.x, v.y + d.y, v.x + d.x, v.y + d.y);
    resetMatrix();
  }

  void moveup() {
    current_location = current_location.add(speed);
    display();
  }

  void movedown() {
    //maybe its better to rotate 180 degree
    //todo: rotate
    current_location = current_location.sub(speed);
    display();
  }

  void moverotate(float angle) {
    speed = speed.rotate(angle);
    direction += angle;

    //println("Rotate", angle, "To Speed:", speed, "and Direction:", direction);
  }

  void moveright() {
    //remove old
    drawPlayerMark(#000000); //background color
    //rotate
    moverotate(delta_r);
    mode++;
    //draw new
    display();
  }

  void moveleft() {
    //remove old
    drawPlayerMark(#000000); //background color
    moverotate(-delta_r);
    mode--;
    //draw new
    display();
  }

  float get_angleSpeed() {
    return degrees(myAngleBetween(speed, get_distVector()));//exit.current_location));
  }

  float get_angleTriangle() {
    return degrees(PVector.angleBetween(current_location, exit.current_location));
    //return degrees(asin((exit.x - current_location.x) / get_dist()));
  }

  float get_dist() {
    return dist(current_location.x, current_location.y, exit.x, exit.y);
  }

  PVector get_distVector() {
    return new PVector(exit.x - current_location.x, exit.y - current_location.y );
  }

  float myAngleBetween (PVector v1, PVector v2) {
  float a = atan2(v2.y, v2.x) - atan2(v1.y, v1.x);
    if (a<0) { 
      a+=TWO_PI;
    }
    return a;
  }


  //float get_distx() {
  //  return current_location.x - exit.x;
  //}

  //float get_disty() {
  //  return current_location.y - exit.y;
  //}
}