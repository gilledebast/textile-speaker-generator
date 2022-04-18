/* ----------------------------------------------------------------------------------------------------
 * Textile Speaker generator, 2017
 * Created: 06/12/17 by Bastien DIDIER
 * 
 * This sketch is used to generate a speaker form to be screen printed with conductive ink
 * 
 * Update: 04/18/22 Current V.1.0
 * ----------------------------------------------------------------------------------------------------
 */
 
import processing.pdf.*;
PGraphicsPDF pdf;

int size_width     = 500;
int size_height    = size_width;

float numofCircles = 12.5; // Circle number
float startRadius  = 1;    // Beginning of the spiral relative to the center
float endRadius    = 200;  // End of the spiral relative to the center
int numSections    = 150;  // The larger the number, the smoother the speaker
int weight         = 10;   // Weight of the line

PVector spiralCenter  = new PVector(size_width/2, size_height/2);
float   currRadius    = startRadius;
float   totalRadian   = numofCircles * PI * 2;
float   startRadian   = -PI;
float   endRadian     = startRadian + totalRadian;
float   currentRadian = startRadian;

// This depends on the current radius
float deltaAngle = totalRadian / numSections;

// Spiral starts from outside
float x = cos(startRadian) * startRadius;
float y = sin(startRadian) * startRadius;

void setup(){
  size(500, 500);
  background(255);
  stroke(0);
  strokeWeight(weight);
  noFill();
  smooth();
  
  pdf = (PGraphicsPDF) beginRecord(PDF, "Speaker_####.pdf");
  
  startRadian -= deltaAngle;
  endRadian += deltaAngle;
  currentRadian = startRadian;
}

void draw(){
  beginShape();
    curveVertex(x + spiralCenter.x, y + spiralCenter.y);
    while (currentRadian < endRadian)
    {
      currentRadian += deltaAngle;
      currRadius = map(currentRadian, startRadian, endRadian, startRadius, endRadius);
      x = cos(currentRadian) * currRadius;
      y = sin(currentRadian) * currRadius;
      curveVertex(x + spiralCenter.x, y + spiralCenter.y);
    }  
  endShape();
  endRecord();
  exit();
}
