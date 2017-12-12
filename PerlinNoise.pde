import java.util.*;

final Random random = new Random();

Noise noise = new Noise();

double xoff = 0;
double yoff = 0;

float rectSize = 1;
float noiseValue;


color col, col2, col3;

void setup() {
  size(1400, 900);
  
  noise.SetOctaves(6);
  noise.SetPersistence(0.5);
  noise.SetFrequency(0.7);
  
  drawNoise();
}

void draw() {
  
}

void mousePressed() {
  drawNoise();
  //saveFrame("./Snapshots/snapshot-#####.png");
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
      
      //noiseValue = (float)(noise.basePerlin(xoff + mult2, yoff + mult2, 0) * 255);
      col2 = int(map(noiseValue, 0, 255, 0, 255));

      //noiseValue = (float)(noise.basePerlin(xoff + mult3, yoff + mult3, 0) * 255);
      col3 = int(map(noiseValue, 0, 255, 0, 255));
      
      noStroke();
      fill(col, col2, col3);
      rect(x, y, rectSize, rectSize);
      
      xoff += 0.01;
    }
    
    xoff = 0;
    yoff += 0.01;
  }
}