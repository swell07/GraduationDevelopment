import oscP5.*;
import netP5.*;

boolean test_alive=true;
Player player;
Map maps;
int highscore, mode;

OscP5 oscP5;
NetAddress myRemoteLocation;
//1-obstacle; 2-win; 3-restart;4-fail
OscMessage MessageAlarm;

//up - 0; down - 1; left - 3; right - 4
OscMessage MessageDirection;
OscMessage MessageMode;
OscMessage MessagePos;
OscMessage MessageStatus1;
OscMessage MessageStatus2;


//declare
int[][] status_num = {
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0}, 
  {1, 0, 0, 1, 1, 1, 2, 0, 0, 0, 0, 0, 2}, 
  {1, 0, 0, 2, 1, 1, 1, 0, 0, 1, 1, 0, 2}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 2}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 0, 1, 1, 1, 2, 2, 2, 1, 1, 1, 2}
};

Point [] points = new Point[104];


void setup() {
  size(650, 400); 
  frameRate(25);
  mode = 1;
  highscore = 0;
  player = new Player(50, height - 50);
  maps = new Map(width, height);
  oscP5 = new OscP5(this, 3344);
  myRemoteLocation = new NetAddress("127.0.0.1", 3345);
  //SETUP IN PURE DATA
  maps.get_environment(player.get_i(), player.get_j());

  MessageMode = new OscMessage("/mode");
  MessageMode.add(player.mode);
  oscP5.send(MessageMode, myRemoteLocation);

  MessagePos = new OscMessage("/pos");
  MessagePos.add(player.get_j() + 1);
  MessagePos.add(-player.get_i() - 1);
  oscP5.send(MessagePos, myRemoteLocation);

  MessageAlarm = new OscMessage("/alarm");
  MessageAlarm.add(0); 
  oscP5.send(MessageAlarm, myRemoteLocation);
}

void draw() {  
  maps.grids();
  maps.display();
  player.display();

  if (mode == 0) {
    if (key == 32) {
      setup();
    }
  }
}


void keyPressed()
{ 
  switch (keyCode) {
  case UP:
    player.moveup();
    maps.get_environment(player.get_i(), player.get_j());
    break;
  case DOWN:
    player.movedown();
    maps.get_environment(player.get_i(), player.get_j());
    break;
  case LEFT:
    player.moveleft();
    break;
  case RIGHT:
    player.moveright();
    break;
  }


  mode_status();
  player_pos();
}

//void test_alive() {
// if ( (player.lives > 0) && (test_falls(player.get_i(), player.get_j())) ) {
//   player.lives--;
//   player = new Player(50, height - 50);
//   println("Failed!!!lives left:" + player.lives + " Score:" + player.scores);
//   //sound -> how many lives lieft, start again!
// } else if (player.lives == 0) {
//   failed();
// }
//}


//--------------sending OSC-------------------
void failed() {
  player.up = false;
  player.down = false;
  MessageAlarm = new OscMessage("/alarm");
  MessageAlarm.add(4); 
  oscP5.send(MessageAlarm, myRemoteLocation);
  println("Game Over!!!" + " Score:" + highscore);
  //sound effects, game over!
  mode = 0;
}

void obstacle() {
  MessageAlarm = new OscMessage("/alarm");
  MessageAlarm.add(1);
  oscP5.send(MessageAlarm, myRemoteLocation);
  println("warning!");
}

void restart() {
  //player = new Player(50, height - 50);
  player.lives--;
  highscore = highscores(highscore, player.scores);
  if (player.lives > 0) {
    player.mode = 0;
    player.x = 50;
    player.y = height - 50;

    MessageMode = new OscMessage("/mode");
    MessageMode.add(player.mode);
    oscP5.send(MessageMode, myRemoteLocation);
    
    MessageAlarm = new OscMessage("/alarm");
    MessageAlarm.add(3);
    oscP5.send(MessageAlarm, myRemoteLocation);
    println("Start Again!" + player.lives + " lives left..." + " Score:" + player.scores);
    //sound effect - falling in the water!!!
    player.scores = 0;
  } else {
    failed();
  }
}

void forward() {
  player.scores ++;
  MessageDirection = new OscMessage("/move");
  MessageDirection.add(0);
  oscP5.send(MessageDirection, myRemoteLocation);
  println("move forward 1 step");
}

void backward() {
  player.scores ++;
  MessageDirection = new OscMessage("/move");
  MessageDirection.add(1);
  oscP5.send(MessageDirection, myRemoteLocation);
  println("move backward 1 step");
}

void turnLeft() {
  MessageDirection = new OscMessage("/move");
  MessageDirection.add(3);
  oscP5.send(MessageDirection, myRemoteLocation);
  println("Turn right");
}

void turnRight() {
  MessageDirection = new OscMessage("/move");
  MessageDirection.add(4);
  oscP5.send(MessageDirection, myRemoteLocation);
  println("Turn right");
}

void win() {
  player.up = false;
  player.down = false;
  MessageAlarm = new OscMessage("/alarm");
  MessageAlarm.add(2); 
  oscP5.send(MessageAlarm, myRemoteLocation);
  highscore = highscores(highscore, player.scores);
  println("You WIN!!!" + " Score:" + highscore);
  //sound effects, game over!
}

void mode_status() {
  MessageMode = new OscMessage("/mode");
  MessageMode.add(player.mode);
  oscP5.send(MessageMode, myRemoteLocation);
}

void player_pos() {
  MessagePos = new OscMessage("/pos");
  MessagePos.add(player.get_j());
  MessagePos.add(7 - player.get_i());
  oscP5.send(MessagePos, myRemoteLocation);
}

int highscores(int high, int scores) {
  if (scores >= high)
  {
    return scores;
  }
  return high;
}