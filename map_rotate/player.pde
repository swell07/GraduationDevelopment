class Player {
  int x, y, mode, lives, scores, speed;
  boolean up = true, down = true;

  Player(int nx, int ny) {
    x=nx;
    y=ny;
    mode = 0;
    scores = 0;
    lives = 3;
    speed = 50;
  }

  void display() {
    fill(#FFFF3F);
    if (mode == 0) {
      triangle(x+25, y, x, y+50, x+50, y+50);
    }
    if (mode == 1) {
      triangle(x, y, x, y+50, x+50, y+25);
    }
    if (mode == 2) {
      triangle(x, y, x+50, y, x+25, y+50);
    }
    if (mode == 3) {
      triangle(x, y+25, x+50, y, x+50, y+50);
    }
  }

  void moveup() {
    //forward
    int i = y / 50;
    int j = x / 50;

    //win
    if ( i == 0 && j == 11) {
      win();
    } else if (up && lives > 0) {
      if (mode == 0) {
        if (test_fall(i-1, j)) {
          restart();
        } else if (test_obstacle(i-1, j)) {
          obstacle(); 
          up = false;
        } else {
          forward();
          y -= speed;
        }
      } else if (mode == 1) {
        if ( test_fall(i, j+1)) {
          restart();
        } else if ( test_obstacle(i, j+1)) {
          obstacle(); 
          up = false;
        } else {
          forward();
          x += speed;
        }
      } else if (mode == 2) {
        if (test_obstacle(i+1, j)) {   
          obstacle();
          up = false;
        } else if (test_fall(i+1, j)) {
          restart();
        } else {
          forward();
          y += speed;
        }
      } else if (mode == 3) {
        if (test_fall(i, j-1)) {
          restart();
        } else if (test_obstacle(i, j-1)) {
          obstacle(); 
          up = false;
        } else {
          forward();
          x -= speed;
        }
      }
      //up = true;
    } else if (!up) {
      obstacle();
      down = true;
    } 
    //else if (lives == 1) {
    //  failed();
    //}
  }

  void moveright() {
    mode = (mode+1)%4;
    turnRight();
    up = true;
    down = true;
  }

  void moveleft() {
    mode = (mode+3)%4;
    turnLeft();
    up = true;
    down = true;
  }

  void movedown() {
    int i = y / 50;
    int j = x / 50;
    if (down && lives > 0) {
      if (mode == 0) {
        if (test_obstacle(i+1, j)) {
          obstacle(); 
          down = false;
        } else if (test_fall(i+1, j)) {
          restart();
        } else {
          forward();
          y += speed;
        }
      } else if (mode == 1) {
        if (test_fall(i, j-1)) {
          restart();
        } else if (test_obstacle(i, j-1)) {
          obstacle(); 
          down = false;
        } else {
          forward();
          x -= speed;
        }
      } else if (mode == 2) {
        if ( test_obstacle(i-1, j)) {
          obstacle(); 
          down = false;
        } else if (test_fall(i-1, j)) {
          restart();
        } else {
          forward();
          y -= speed;
        }
      } else if (mode == 3) {
        if (test_fall(i, j+1)) {
          restart();
        } else if (test_obstacle(i, j+1)) {
          obstacle(); 
          down = false;
        } else {
          forward();
          x += speed;
        }
      }
    } else if (!down) {
      obstacle();
      up = true;
    } 
    //else if (lives == 1) {
    //  failed();
    //}
  }

  int getmode() {
    return mode;
  }

  int get_j() {
    return x/50;
  }
  int get_i() {
    return y/50;
  }

  //obstacle
  boolean test_obstacle(int i, int j) {
    if (get_status(i, j) == 2 || get_status(i, j) == 5) {
      return true;
    }
    return false;
  }

  boolean test_fall(int i, int j) {
    if (get_status(i, j) == 1 ) {
      return true;
    }
    return false;
  }
}

boolean test_falls(int i, int j) {
  if (status_num[i][j] == 1) {
    return true;
  }
  return false;
}