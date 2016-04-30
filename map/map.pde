boolean test_alive = true;
//River[][] rivers;
River rivers;
Player player;
int mode = 0;

void setup() {
  size (650, 400);
  drawmap();
  rivers = new River(0, 50);
  player = new Player(50, height-50);
}



void draw() {
  rivers.display();
  player.display();
  
}


void drawmap() {
  background(0);
  stroke(130);
  for (int i = 0; i < width / 50; i++) {
    int x = (i+1)*50;
    line(x, 0, x, height);
  }
  for (int j = 0; j < height / 50; j++) {
    int y = (j+1)*50;
    line(0, y, width, y);
  }
}

//void keyPressed()
//{ 
//  test_alive();

//  switch (keyCode) {
//  case UP:
//    player.moveup();
//    break;
//  case DOWN:
//    player.movedown();
//    break;
//  case LEFT:
//    player.moveleft();
//    break;
//  case RIGHT:
//   player.moveright();
//    break;
//  }
//}