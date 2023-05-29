// Client.pde
import processing.net.*;

Client c;
float clientBallX, clientBallY;

void setup() {
  size(400, 400);
  c = new Client(this, "127.0.0.1", 12345);
}

void draw() {
  background(255);

  clientBallX = mouseX;
  clientBallY = mouseY;
  
  c.write(clientBallX + "," + clientBallY + "\n");
  
  if (c.available() > 0) {
    String data = c.readStringUntil('\n');
    if (data != null) {
      String[] coordinates = data.split(",");
      if (coordinates.length == 2) {
        float serverBallX = float(coordinates[0]);
        float serverBallY = float(coordinates[1]);
        fill(255, 0, 0);
        ellipse(serverBallX, serverBallY, 20, 20);
      }
    }
  }

  fill(0, 0, 255);
  ellipse(clientBallX, clientBallY, 20, 20);
}
