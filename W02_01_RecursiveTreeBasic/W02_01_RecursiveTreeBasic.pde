/*-----------------------------------------------------------------------
                      Author: Siddhartha Mukherjee 
                Generative Algorithms for Art & Design
            Workshop week at IDC School of Design, IITB, 2023

A simple fractal tree algorithm using recursion. Also demonstrates how to 
vary parameters (a) for making a perfect loop and (b) using mouse controls.
---------------------------------------------------------------------------*/

float thVar = PI/6.0;
float lenFrac = 0.6;
float dt = 0.034906;

color [] cols = { #390099, #9e0059, #ff0054, #ff5400, #ffbd00 };
color colBr = cols[4];

void setup() {
	size(600,600);
	background(0);
}

void draw() {
	fill(0, 255);
	noStroke();
	rect(0,0,width,height);
	tree();

	//-- Sinusoidally varying parameters for a looping animation
	thVar = sin(frameCount*dt)*TWO_PI*0.2;	
	lenFrac = map(sin(frameCount*dt), -1, 1, 0.5, 0.7);

	//-- Uncomment below to use mouse interaction to vary parameters instead
	// thVar = map(mouseX, 0, width, -PI, PI);
	// lenFrac = map(mouseY, 0, height, 0.5, 0.8);
}

void mousePressed() {
  save("../04-Tree.png");  
}


void tree() {
	branch( width*0.5, height*0.95, 200.0, 0);
}


//-- The function that draws branches recursively
void branch( float xb, float yb, float len, float th ) {
	stroke(colBr);
  //-- Change strokeweight for smaller branches as they are made
	strokeWeight(0.5 + len*0.025);
  
	float xf = xb+sin(th)*len;
	float yf = yb-cos(th)*len;
	line( xb, yb, xf, yf );

	if(len>20) {
		branch( xf, yf, len*lenFrac, th+thVar);
		branch( xf, yf, len*lenFrac, th-thVar*0.7);
	} else {
		//-- Changing flower colours every 10 frames
		stroke( cols[int(frameCount*0.1)%cols.length] );
		strokeWeight( 2.5 );
		ellipse(xb+sin(th)*len, yb-cos(th)*len, 10, 10);
	}
}
