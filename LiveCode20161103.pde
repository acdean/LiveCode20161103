import peasy.*;

int SIZE = 50;
int MAG = 20;

PeasyCam cam;
float[][] z = new float[SIZE][SIZE];
GravityWell g0, g1;

void setup() {
  size(640, 360, P3D);
  cam = new PeasyCam(this, 500);
  g0 = new GravityWell();
  g1 = new GravityWell();
}

void draw() {
  background(0);
  strokeWeight(1);
  stroke(0, 255, 0);
  noFill();
  translate(-MAG * SIZE / 2, -MAG * SIZE / 2);
  beginShape(QUAD);
  for (int y = 0; y < SIZE - 1; y++) {
    for (int x = 0; x < SIZE - 1; x++) {
      vertex(x * MAG, y * MAG, z[x][y]);
      vertex((x + 1) * MAG, y * MAG, z[x + 1][y]);
      vertex((x + 1) * MAG, (y + 1) * MAG, z[x + 1][y + 1]);
      vertex(x * MAG, (y + 1) * MAG, z[x][y + 1]);
    }
  }
  endShape();
  strokeWeight(10);
  fill(0, 0, 255);
  stroke(0, 0, 255);
  g0.move();
  g1.move();
  point(g0.x, g0.y);
  point(g1.x, g1.y);
}

class GravityWell {
  float a = random(TWO_PI);
  float d = random(-.02, .02);
  float px = random(-5, 5);
  float py = random(-5, 5);
  public float x, y;
  
  void move() {
    a += d;
    x = SIZE * MAG * (.5 + .5 * sin(a * px));
    y = SIZE * MAG * (.5 + .5 * sin(a * py));
  }
}