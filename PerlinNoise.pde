import java.util.*;
import java.text.*;

final Random random = new Random();

Noise noise = new Noise();

double xoff = 0;
double yoff = 0;

double x = 0;
double y = 0;

float rectSize = 1;
float noiseValue;
float maxNoiseHeight = -1;
float minNoiseHeight = 2;

double seed = 0;

float noiseMap[][];

boolean heightMap = false;

color col;

void setup() {
  size(1400, 900);
  
  background(28, 166, 255);
  
  frameRate(10000);
  
  noise.SetOctaves(5);
  noise.SetPersistence(0.5);
  noise.SetFrequency(0.7);
  noise.SetLacunarity(2);
  
  DrawTerrain();
}

void draw() {
  //background(0);
  //noise.SetOctaves((int)map(mouseX, 0, width, 1, 18));
  //noise.SetPersistence(map(mouseY, 0, height, 0, 10));
  //noise.SetFrequency(map(mouseY, 0, height, 1, 16));
  //noise.SetLacunarity(map(mouseY, 0, height, 0, 16));
  
  //seed = map(mouseX, 0, width, 0, 10);
  
  //x = map(mouseX, 0, width, 0, 5);
  //y = map(mouseY, 0, height, 0, 5);
  //seed = map(mouseY, 0, height, 0, 5);
  
  /*DecimalFormat df = new DecimalFormat("###.##");
  seed += 0.01;
  seed = Double.parseDouble(df.format(seed).replace(",","."));*/
  //x += 0.01;
  //y += 0.01;
  
  DrawTerrain();
}

void mousePressed() {
  String str = String.format("seed-%2f-octaves-%d-persistence-%.2f-frequency-%.2f-lacunarity-%.2f", seed, noise.octaves, noise.persistence, noise.frequency, noise.lacunarity);
  saveFrame("./Snapshots/" + str + ".png");
  
  //if(heightMap) heightMap = false;
  //else heightMap = true;
}

float[][] GetNoiseMap() {
  xoff = 0;
  yoff = 0;

  float[][] noiseMap = new float[height][width];
  
  for(int y = 0; y < height; y += rectSize) {
    for(int x = 0; x < width; x += rectSize) {
      noiseValue = (float)(noise.perlin(xoff + this.x, yoff + this.y, seed));
      
      //noiseValue = noise((float)xoff, (float)yoff);
      
      if(noise.perlin(xoff + this.x, yoff + this.y, seed) > maxNoiseHeight) {
        maxNoiseHeight = noiseValue;
      } 
      else if (noise.perlin(xoff + this.x, yoff + this.y, seed) < minNoiseHeight) {
        minNoiseHeight = noiseValue;
      }
      
      noiseMap[y][x] = noiseValue;

      xoff += 0.01;
    }
    
    xoff = 0;
    yoff += 0.01;
  }
  
  return noiseMap;
}

void DrawTerrain() {
  float[][] noiseMap = GetNoiseMap();
  
  for(int y = 0; y < height; y += rectSize) {
    for(int x = 0; x < width; x += rectSize) {
      
      noiseValue = map(noiseMap[y][x], minNoiseHeight, maxNoiseHeight, 0, 1);
      
      //noiseValue = random.nextFloat() * 1;
      
      noStroke();
      
      if(noiseValue < 1)     fill(255, 255, 255);          // snow
      if(noiseValue < 0.89)  fill(59, 38, 18);             // rock 2
      if(noiseValue < 0.70)  fill(78, 50, 24);             // rock
      if(noiseValue < 0.63)  fill(0, 153, 0);              // grass
      if(noiseValue < 0.53)  fill(0, 204, 0);              // grass 2
      if(noiseValue < 0.48)  fill(255, 255, 102);          // sand
      if(noiseValue < 0.42)  fill(51, 102, 255);           // water
      if(noiseValue < 0.3)   fill(0, 51, 204);             // deep water
      
      
      /*
      if(noiseValue > 0.5) {
        fill(noiseValue * 255, noiseValue * 255, noiseValue *  255); 
        rect(x, y, rectSize, rectSize);
      }*/
      
     
      if(heightMap) fill(noiseValue * 255);
     
      rect(x, y, rectSize, rectSize);
    }
  }
}