/*-----------------------------------------------------------------------
                      Author: Siddhartha Mukherjee 
                Generative Algorithms for Art & Design
            Workshop week at IDC School of Design, IITB, 2023

A minimal working example of adding interactivity using the microphone.
---------------------------------------------------------------------------*/

//-- You need to install the minim library for this
import ddf.minim.*;
import ddf.minim.analysis.*;
Minim minim;
AudioInput in;

FFT fft;

float[] amp;
int ampLen = 256;
int bufferSize = 1024;
float cutoff = 1.0;
float sum = 0.0;

void setup() {
  size(800,800);
  background(0);
  
  amp = new float[ampLen];
  minim = new Minim(this);
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn( Minim.MONO, 1024 );
  fft = new FFT(in.bufferSize(), in.sampleRate());  
}

void draw() {
  noStroke();
  fill(0,10);
  rect(0,0,width,height);
  
  fft.forward(in.mix);
  sum = 0.0;
  for(int i=0; i<ampLen; ++i) {
    amp[i] = fft.getBand(i) > cutoff ? fft.getBand(i) : 0.0;
    sum += amp[i];
  }

  // stroke(255);
  noStroke();
  fill(map(sum, 0, 1000, 0, 255), 0, map(sum, 0, 1000, 255, 0), 255);
  float r = map(sum, 0, 1000, 0, 400);
  ellipse(width*0.5, height*0.5, r, r );
  
}
