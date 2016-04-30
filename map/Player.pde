class Player {
  int x, y, speed;
  boolean right = true, left = true, up = true, down = true, kimleft = false;
  int score = 0, lives = 3;

  Player(int nx, int ny) {
    x = nx;
    y = ny;
  }


  //kimleft decides the face direction of KIM
  void display() {
    fill(#FFFF6F);
    rect(x, y, 50, 50);
  }


  void moveup() {
    if (up) {
      if (y >=50 ) {
        y -= 50;
        if (test_fall(x, y)) {     
          x = 50;
          y = 550;
          lives--;
        }else{
        score ++;
      }
    }
  }
  up = true;
}


public void movedown() {
  if (down) {
    if ( y == 240) {
      // y += 40;
      x = (round(x/40)) * 40;
    }
    if (y < 520) {
      y += 40;
    } else {
      y = 520;
    }
  }
  down = true;
}


public void moveright() {
  if (right) {
    if (x < width - 40) {
      kimleft = false;
      x += 40;
    } else {
      x = width - 40;
    }
  }
  right = true;
}



public void moveleft() {
  if (left) {
    if (x > 0 ) {
      kimleft = true;
      x -= 40;
    } else {
      x= 0;
    }
  }
  left = true;
}


public int get_x() {
  return x;
}

public int get_y() {
  return y;
}


public int kim_lives() {
  return lives;
}

public int kim_score() {
  return score;
}

public void update() {
  x += speed;
}

//test hit, reset Kim
public void hithithit() {
  //rect()

  if (--lives == 0) {
    mode = 2;
  } else {
    x = 200;
    y = 520;
  }
}
}


/*  
 void movement() {
 //KIM LEFT/RIGHT MOVEMENT
 if (x > width - 40 ) x = width - 40;
 if (x < 0) x = 0;
 if (x <= width - 40 && keyright) {
 stop = false;
 } else if (x >= 0 && keyleft) {
 stop = true;
 }
 
 //KIM DIRECTION
 if (stop == true) {
 KimL(x, y);
 } else if (stop == false) {
 KimR(x, y);
 }
 }
 }
 
 void KimL(float kimX, float kimY) {
 image(kimL, kimX, kimY);
 }
 
 void KimR(float kimX, float kimY) {
 image(kimR, kimX, kimY);
 }
 */