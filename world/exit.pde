class Exit {

  PVector current_location;
  float x, y;

  Exit(PVector init_location) {
    current_location = init_location;
    x = current_location.x;
    y = current_location.y;
  }

  void display() {
    fill(#FFF3FF);
    rect(x, y, 20, 20);
  }
}