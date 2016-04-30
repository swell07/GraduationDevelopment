class Point {
  int x, y, d;
  String status;

  Point(int nx, int ny, String isWhat) {
    x = nx;
    y = ny;
    d = 50;
    status = isWhat;
  }

  void display() {
    if (status == "isRiver") {
      fill(#40C1FF);
      rect(x, y, d, d);
    }
    if (status == "isLand") {
      fill(#764D0A);
      rect(x, y, d, d);
    }
    if (status == "isBird") {
      fill(#71FF0D);
      ellipse(x + d/2, y + d/2, d, d);
    }
  }
 
}