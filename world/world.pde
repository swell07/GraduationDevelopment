import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;
OscMessage MessagePos;
OscMessage MessageMode;

PVector vplayer, vexit;
Player player;
Exit exit;

void setup()
{
  background(0);
  size(600, 600);
  frameRate(25);

  vexit = new PVector(580, 0);
  exit = new Exit(vexit);
  exit.display();
  vplayer = new PVector(300, 300);
  player = new Player(vplayer);
  player.display();

  oscP5 = new OscP5(this, 4445);
  myRemoteLocation = new NetAddress("127.0.0.1", 4444);
  MessagePos = new OscMessage("/pos");
  //MessagePos.add(player.get_distx()/width);
  //MessagePos.add(player.get_disty()/height);
  MessagePos.add(player.get_dist());
  oscP5.send(MessagePos, myRemoteLocation);

  MessageMode = new OscMessage("/mode");
  MessageMode.add(player.mode);
  oscP5.send(MessageMode, myRemoteLocation);
}

void draw()
{
}

void keyPressed()
{ 
  switch (keyCode) {
  case UP:
    player.moveup();
    break;
  case DOWN:
    player.movedown();
    break;
  case LEFT:
    player.moveleft();
    break;
  case RIGHT:
    player.moveright();
    break;
  }
  //println("dist:" +player.get_dist() + ", " + dist_map(player.get_dist()));//"distx:"+ (player.current_location.x - exit.x)+ ", disty:" +(player.current_location.y - exit.y));
  println("angle:" + player.get_angleSpeed() + " + " + player.get_angleTriangle());//"angle Between: " + (player.get_angleTriangle() - player.get_angleSpeed()) ); //
  //println(player.get_distVector());
  //println(player.current_location);//player.mode);//


  MessageMode = new OscMessage("/mode");
  MessageMode.add(player.mode);
  oscP5.send(MessageMode, myRemoteLocation);

  MessagePos = new OscMessage("/pos");
  //MessagePos.add(player.get_distx()/width);
  //MessagePos.add(player.get_disty()/height);
  MessagePos.add(dist_map(player.get_dist()));//clip 0 1
  oscP5.send(MessagePos, myRemoteLocation);
}

float dist_map(float d) {
  return map(d, 800, 20, 0, 1);
}