import java.util.*;

final Random random = new Random();

Noise noise = new Noise();

double xoff = 0;
double yoff = 0;

double x = 0;
double y = 0;

float rectSize = 5;
float noiseValue;

double seed = 0;

color col;

void setup() {
  size(800, 800);
  
  frameRate(10000);
  
  noise.SetOctaves(5);
  noise.SetPersistence(0.5);
  noise.SetFrequency(1);
  noise.SetLacunarity(2);
  
  drawNoise();
}

void draw() {
  //noise.SetOctaves((int)map(mouseX, 0, width, 1, 18));
  //noise.SetPersistence(map(mouseY, 0, height, 0, 1));
  //noise.SetFrequency(map(mouseY, 0, height, 1, 16));
  //noise.SetLacunarity(map(mouseY, 0, width, 0, 16));
  
  //seed = map(mouseX, 0, width, 0, 100);
  
  x = map(mouseX, 0, width, 0, 100);
  y = map(mouseY, 0, height, 0, 100);
  
  drawNoise();
}

void mousePressed() {
  drawNoise();
  //saveFrame("./Snapshots/snapshot-#####.png");
}

void drawNoise() {
  xoff = 0;
  yoff = 0;
  
  float maxNoiseHeight = -1;
  float minNoiseHeight = 2;
  
  float[][] noiseMap = new float[height][width];
  
  for(int y = 0; y < height; y += rectSize) {
    for(int x = 0; x < width; x += rectSize) {
      noiseValue = (float)(noise.perlin(xoff + this.x, yoff + this.y, seed));
      
      if(noise.perlin(xoff + this.x, yoff + this.y, seed) > maxNoiseHeight) {
        maxNoiseHeight = noiseValue;
      } 
      else if (noise.perlin(xoff + this.x, yoff + this.y, seed) < minNoiseHeight) {
        minNoiseHeight = noiseValue;
      }
      
      noiseMap[x][y] = noiseValue;

      xoff += 0.03;
    }
    
    xoff = 0;
    yoff += 0.03;
  }
  
  for(int y = 0; y < height; y += rectSize) {
    for(int x = 0; x < width; x += rectSize) {
      
      noiseValue = map(noiseMap[x][y], minNoiseHeight, maxNoiseHeight, 0, 1);
      
      noStroke();
      fill(noiseValue * 255);
      rect(x, y, rectSize, rectSize);
    }
  }
}