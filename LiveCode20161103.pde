import peasy.*;

int SIZE = 100;
int MAG = 20;

PeasyCam cam;
float[][] z = new float[SIZE][SIZE];

void setup() {
  size(640, 360, P3D);
  cam = new PeasyCam(this, 500);
}

void draw() {
  background(0);
  stroke(0, 255, 0);
  noFill();
  translate(-MAG * SIZE / 2, -MAG * SIZE / 2);
  beginShape(QUAD);
  for (int y = 0; y < SIZE - 1; y++) {
    for (int x = 0; x < SIZE - 1; x++) {
      vertex(x * MAG, y * MAG);
      vertex((x + 1) * MAG, y * MAG);
      vertex((x + 1) * MAG, (y + 1) * MAG);
      vertex(x * MAG, (y + 1) * MAG);
    }
  }
  endShape();
}