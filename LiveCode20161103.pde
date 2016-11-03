import peasy.*;

int SIZE = 50;
int MAG = 20;
int WELLS = 20;
boolean video = true;

PeasyCam cam;
float[][] z = new float[SIZE][SIZE];
GravityWell[] wells = new GravityWell[WELLS];

void setup() {
  size(640, 360, P3D);
  cam = new PeasyCam(this, 500);
  for (int i = 0 ; i < WELLS ; i++) {
    wells[i] = new GravityWell();
  }
}

void draw() {
  background(0);
  
  // calc z
  for (int y = 0; y < SIZE; y++) {
    for (int x = 0; x < SIZE; x++) {
      float val = 0;
      for (int well = 0 ; well < WELLS ; well++) {
        // square of distance
        float d2 = sq(x - wells[well].x / MAG) + sq(y - wells[well].y / MAG);
        val += 50 / (d2 + 4);
      }
      z[x][y] = 10 * val;
    }
  }

  
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
  for (int i = 0 ; i < WELLS ; i++) {
    wells[i].move();
    point(wells[i].x, wells[i].y);
  }
  
  if (video) {
    saveFrame("frame#####.png");
    if (frameCount > 500) {
      exit();
    }
  }
}

class GravityWell {
  float a = random(TWO_PI);
  float d = random(-.012, .012);
  float px = random(-3, 3);
  float py = random(-3, 3);
  public float x, y;
  
  void move() {
    a += d;
    x = SIZE * MAG * (.5 + .5 * sin(a * px));
    y = SIZE * MAG * (.5 + .5 * sin(a * py));
  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame("snap####.png");
  }
}