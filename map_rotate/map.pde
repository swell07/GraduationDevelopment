class Map {
  int x, y;
  //ArrayList<Point> points = new ArrayList<Point>(); 

  Point [] points = new Point[104];
  Map(int nx, int ny) {
    x=nx;
    y=ny;
    //status_num = num;
    //points = new Point[status_num][104];
  }

  void grids() {
    background(0);
    stroke(130);
    for (int i = 0; i < x / 50; i ++) {
      line(i*50, 0, i*50, y);
    }
    for (int j = 0; j < y / 50; j ++) {
      line(0, j*50, x, j*50);
    }
  }


  void display() {
    for (int i  = 0; i < 8; i++) {
      for (int j = 0; j < 13; j++) {
        if (status_num[i][j] == 0) {
          int n = i*8 + j;
          points[n] = new Point(j*50, i*50, "isLand");
          points[n].display();
        }
        if (status_num[i][j] == 1) {
          int n = (i+1) * (j+1) - 1;
          points[n] = new Point(j*50, i*50, "isRiver");
          points[n].display();
        }
        if (status_num[i][j] == 2) {
          int n = (i+1) * (j+1) - 1;
          points[n] = new Point(j*50, i*50, "isBird");
          points[n].display();
        }
      }
    }
  }

  void get_environment(int i, int j) {
  int[] environment1 = new int[8];
  int[] environment2 = new int[16];
    for (int n = 0; n < 8; n++) {
      environment1[0] = get_status(i-1, j-1);
      environment1[1] = get_status(i-1, j);
      environment1[2] = get_status(i-1, j+1);
      environment1[3] = get_status(i, j+1);
      environment1[4] = get_status(i+1, j+1);
      environment1[5] = get_status(i+1, j);
      environment1[6] = get_status(i+1, j-1);
      environment1[7] = get_status(i, j-1);
    }
    
     for (int n = 0; n < 16; n++) {
      environment2[0] = get_status(i-2, j-2);
      environment2[1] = get_status(i-2, j-1);
      environment2[2] = get_status(i-2, j);
      environment2[3] = get_status(i-2, j+1);
      environment2[4] = get_status(i-2, j+2);
      environment2[5] = get_status(i-1, j+2);
      environment2[6] = get_status(i, j+2);
      environment2[7] = get_status(i+1, j+2);
      environment2[8] = get_status(i+2, j+2);
      environment2[9] = get_status(i+2, j+1);
      environment2[10] = get_status(i+2, j);
      environment2[11] = get_status(i+2, j-1);
      environment2[12] = get_status(i+2, j-2);
      environment2[13] = get_status(i+1, j-2);
      environment2[14] = get_status(i, j-2);
      environment2[15] = get_status(i-1, j-2);
    }

    MessageStatus1 = new OscMessage("/environment1");
    MessageStatus1.add(environment1);
    oscP5.send(MessageStatus1, myRemoteLocation);
    //println(environment1);

    MessageStatus2 = new OscMessage("/environment2");
    MessageStatus2.add(environment2);
    oscP5.send(MessageStatus2, myRemoteLocation);
  }
}

int get_status(int i, int j) {
  if ( i < 0 || i > 7 || j < 0 || j > 12) {
    return 5;
  }
  return status_num[i][j];
}