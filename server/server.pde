import processing.net.*;

Server s;
Client c;
float serverBallX, serverBallY;

void setup() {
  size(400, 400);
  s = new Server(this, 12345);
}

void draw() {
  background(255);
  
  c = s.available();
  if (c != null && c.available() > 0) {
    String data = c.readStringUntil('\n');
    if (data != null) {
      String[] coordinates = data.split(",");
      if (coordinates.length == 2) {
        float clientBallX = float(coordinates[0]);
        float clientBallY = float(coordinates[1]);

        serverBallX = width - clientBallX;
        serverBallY = height - clientBallY;
        c.write(serverBallX + "," + serverBallY + "\n");
      }
    }
  }
  fill(255, 0, 0);
  ellipse(serverBallX, serverBallY, 20, 20);
}
