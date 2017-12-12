import java.util.*;

final Random random = new Random();

Noise noise = new Noise();

double xoff = 0;
double yoff = 0;
float rectSize = 5;
float noiseValue;


color col, col2, col3;
void setup() {
  size(1400, 900);
    
  drawNoise();
}

void draw() {
  
}

void mousePressed() {
  drawNoise();
  saveFrame("./Snapshots/snapshot-#####.png");
}

void drawNoise() {
  int mult1 = random.nextInt(10000);
  int mult2 = random.nextInt(10000);
  int mult3 = random.nextInt(10000);
  
  println(mult1, " ", mult2, " ", mult3);
  
  for(int y = 0; y < height; y += rectSize) {
    for(int x = 0; x < width; x += rectSize) {
      
      noiseValue = (float)(noise.perlin(xoff + mult1, yoff + mult1, 0) * 255);
      col = int(map(noiseValue, 0, 255, 0, 255));
      
      noiseValue = (float)(noise.perlin(xoff + mult2, yoff + mult2, 0) * 255);
      col2 = int(map(noiseValue, 0, 255, 0, 255));

      noiseValue = (float)(noise.perlin(xoff + mult3, yoff + mult3, 0) * 255);
      col3 = int(map(noiseValue, 0, 255, 0, 255));
      
      noStroke();
      fill(col, col2, col3);
      rect(x, y, rectSize, rectSize);
      
      xoff += 0.1;
    }
    
    xoff = 0;
    yoff += 0.1;
  }
}