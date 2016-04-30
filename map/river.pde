class River {
  int x, y;

  River(int nx, int ny) {
    x = nx;
    y = ny;
  }

  void display() {
    fill(#6FE1FF);
    rect(x, y, 50, 50);
  }

  boolean test_fall(int player_x, int player_y)
  {
    if (player_x <= x + 10 && player_x <= x + 50) { 
      return true;
    }
    return false;
  }
}

//for player
boolean test_fall(int x, int y) {
 if (rivers.test_fall(x, y)) {
   return true;
 }
 return false;
}