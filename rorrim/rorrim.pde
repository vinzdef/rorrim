// Adapted from: 
// https://github.com/shiffman/OpenKinect-for-Processing/blob/master/OpenKinect-Processing/examples/Kinect_v1/RGBDepthTest/RGBDepthTest.pde
// Thanks Dan, you're the real MVP.

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Kinect kinect;

float deg;
int scale = 3;

void setup() {
  size(1920, 1440);
  kinect = new Kinect(this);
  background(0);
  
  kinect.initDepth();
  kinect.initVideo();

  kinect.enableColorDepth(false);
  kinect.enableMirror(true);
  colorMode(HSB, 255);
  
  
}

//Boolean isBgSet = false;

void draw() {
  fill(0,0,0,10);
  rect(0,0,width,height);
  
  PImage img = kinect.getDepthImage();
  
  img.filter(POSTERIZE, 255);
  img.filter(BLUR, 1);
  
  int tileW = 2;
  for (int x = 0; x < img.width; x+=tileW)
    for (int y = 0; y < img.height; y+=tileW) {
      int index = x + y * img.width;
      float depth = (red(img.pixels[index]) - 140) / 115;
      if (depth > 1) depth = 1;
            
      if (depth < 0.15) {
        continue;  
      }
      
      color c = color(depth * 255 * 3, 126, 255);
      fill(c);
      rect(x * scale, y * scale, tileW * scale, tileW * scale);
    }
}
