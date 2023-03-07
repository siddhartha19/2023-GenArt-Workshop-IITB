/*-----------------------------------------------------------------------
                      Author: Siddhartha Mukherjee 
                Generative Algorithms for Art & Design
            Workshop week at IDC School of Design, IITB, 2023

An example showing how adding a phase difference between space-filling shapes
can lead to a display-like behaviour, as well as show larger scale dynamics.
---------------------------------------------------------------------------*/

int step = 25;
color [] colorList = { #f6bd60, #f7ede2, #f5cac3, #84a59d, #f28482 };

float ns = 0.002;
float dt = 0.04;
int [] cindx;

void setup() {
  size(1000,400);
  rectMode(CENTER);
  
  int cc = 0;
  for(int i=0; i<width; i+=step) {
    for( int j=0; j<height; j+=step ) {
      cc++;
    }
  }
  
  cindx = new int[cc];
  for(int i=0; i<cc; ++i) 
    cindx[i] = int(random(colorList.length));
}

void draw() {
  pattern();
}

void mousePressed() {
  save("../03-Blink.png");

}

void pattern() {
  background( colorList[0] );
  
  int cc = 0;
  for(int i=0; i<width; i+=step) {
    for( int j=0; j<height; j+=step ) {
           
      fill( colorList[ cindx[cc] ], 255 );
      noStroke();
      pushMatrix();
      translate(i+step*0.5, j+step*0.5);
      float ph = noise( i*ns, j*ns )*TWO_PI;
      rect( 0,0,step*(sin( ph+frameCount*dt ))*0.9, step*(sin( ph+frameCount*dt ))*0.9 );
      popMatrix();
      cc++;

    }
  }
}
