/*-----------------------------------------------------------------------
                      Author: Siddhartha Mukherjee 
                Generative Algorithms for Art & Design
            Workshop week at IDC School of Design, IITB, 2023

Using the particle system as a drawing agent, by connecting lines between 
closeby particles and moving them. The initial location of the particles
can be used to trace out geometric (or typographical) shapes, giving a nice
glowing effect to the trailing wisps using blendMode(ADD).
---------------------------------------------------------------------------*/

int np = 250; //-- Number of particles
particle [] p;
float ns = 0.004;

color [] colorList = { #390099, #9e0059, #ff0054, #ff5400, #ffbd00 };

void setup() {
	size(800,800);
	background(0);
	blendMode(ADD);

	p = new particle[np];
	for(int i=0; i<np; ++i) {
		p[i] = new particle();
	}
  
  //-- Reinitalize particles to a random shape
  float R1 = random(0.2,0.4)*width;
  float R2 = random(0.2,0.4)*height;
  float k1 = int(random(1,5));
  float k2 = int(random(1,5));
  for(int i=0; i<np; ++i) {
  	//-- You can add a lot more complexity to the initial positions, and play with different combinations of sines and cosines
    p[i].x = width*0.5 + R1*(cos(k1*TWO_PI*i/np)+sin(k2*TWO_PI*i/np))*0.5;
    p[i].y = height*0.5 + R2*sin(k2*TWO_PI*i/np);
  }
  
}

void draw() {
	noStroke();
	fill(0,0);
	rect(0,0,width,height);

	for(int i=0; i<np; ++i) {
		p[i].move();
		if(frameCount< 160)p[i].show();
	}

	//-- Only draw upto a short time
	if(frameCount<160) connect();

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
		stroke(cc,10);
		strokeWeight(random(3));
		point( x, y  );
	}

	void move() {
    	th += random(-1,1)*0.4;
		x += rad*cos(th);
		y += rad*sin(th);

		x = (x+width)%width;
		y = (y+height)%height;
	}
}

void connect() {
  for(int i=0; i<np-1; ++i) {
    for(int j=i+1; j<np; ++j) {
      if( dist( p[i].x, p[i].y, p[j].x, p[j].y ) < 25 ) {
      	//-- Tweak the alpha value of the stroke to suit your sketch!
        stroke( colorList[int(random(colorList.length))], 10 );
        strokeWeight(1);
        line( p[i].x, p[i].y, p[j].x, p[j].y );
        //-- Optionally, a symmetric line mirrored over the x=width/2 axis
        // line(width- p[i].x, p[i].y, width-p[j].x, p[j].y );
      }
    }
  }
}
