/*-----------------------------------------------------------------------
                      Author: Siddhartha Mukherjee 
                Generative Algorithms for Art & Design
            Workshop week at IDC School of Design, IITB, 2023

A basic particle system, with smooth motion through space. Connecting particle
pairs within a given distance. The same system can be modified to add more
intricate dynamics, physical forces or used as a drawing agent as shown in the 
next sketch.
---------------------------------------------------------------------------*/

int np = 250; //-- Number of particles
particle [] p;
float ns = 0.004;
float dmax = 50.0;

color [] colorList = { #390099, #9e0059, #ff0054, #ff5400, #ffbd00 };
color bg = #000000;

void setup() {
  size(800,800);
  background(bg);

  //-- Initialize all particles
	p = new particle[np];
	for(int i=0; i<np; ++i) {
		p[i] = new particle();
  }
}

void draw() {
	noStroke();
  fill(bg,150);
	rect(0,0,width,height);

  //-- Move and show particles
	for(int i=0; i<np; ++i) {
		p[i].move();
		p[i].show();
	}

  //-- Connect particles
  connect();
}

void mousePressed() {
  save("../05-ParticlesConnect.png");
}

class particle{
	float x, y, rad, th;
  color cc;

	particle() {
		x = random(width);
		y = random(height);
		rad = random(2);
		th = random(TWO_PI);
    cc = colorList[int(random(colorList.length))];
	}

	void show() {
		stroke(cc,255);
		strokeWeight(8);
		point( x, y );
	}

	void move() {
		// th = noise( x*ns, y*ns )*TWO_PI+PI;
    //-- Incrementing each particles movement angle as a random walk, and using that to increment the position
    th += random(-1,1)*0.4;
		x += rad*cos(th);
		y += rad*sin(th);

    //-- Add periodicity
		x = (x+width)%width;
		y = (y+height)%height;
	}
}

void connect() {
  for(int i=0; i<np-1; ++i) {
    for(int j=i+1; j<np; ++j) {
      //-- Connect particle pairs within a distance dmax
      if( dist( p[i].x, p[i].y, p[j].x, p[j].y ) < dmax ) {
        stroke( p[i].cc, 255 );
        strokeWeight(1);
        line( p[i].x, p[i].y, p[j].x, p[j].y );
      }
    }
  }
}
