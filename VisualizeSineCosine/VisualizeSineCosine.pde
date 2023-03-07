/*-----------------------------------------------------------------------
                      Author: Siddhartha Mukherjee 
                Generative Algorithms for Art & Design
            Workshop week at IDC School of Design, IITB, 2023

A visualizer for trigonometric functions useful for dynamics and shapes. In
the getTrig() function, you can add your own formulas. Mouseclick refreshes 
the visualization.
---------------------------------------------------------------------------*/

float time = 0.0;
float dt = 0.04;

color bg = #323031;
PFont font;

void setup() {
	size(1000,1000);
	background(bg);
	font = createFont("Montserrat-Regular.otf", 32);
	textFont(font);
}

void draw() {
	noStroke();
	//-- Panel 1
	fill(bg, 25);
	rect(0,0,width, height*0.5);
	rect(0,0,width*0.5, height);

	myFunction();
	time += dt;

}

void mousePressed() {
  background(bg);
}

float [] getTrig() {
	float rad = width*0.1;

	//-- Enter your function here!
	float x = rad*(cos(3.0*time) - sin(2.0*time));
	float y = rad*(sin(time)*cos(0.5*time));

	float [] p = {x, y};
	return p;
}

void myFunction() {

  	float [] p = getTrig();
  	rectMode(CENTER);
	//-- Panel 1
	color cc = #ffc857;
	float xoff = -0.0;
	pushMatrix();
	translate( width*0.25, height*0.25 );
  	fill(cc); textSize(30); stroke(cc); textAlign(CENTER);
	text("Trajectory", xoff , height*0.2);	
	strokeWeight(8); point( p[0], p[1] );

	noFill(); strokeWeight(1.5);
	rect(0,0,width*0.45, height*0.45);
	popMatrix();

	//-- Panel 2
	cc = #db3a34;
	pushMatrix();
	translate( width*0.75, height*0.25 );
	fill(cc); textSize(30); stroke(cc); textAlign(CENTER);
	text("Y Movement", xoff , height*0.2);
	strokeWeight(8); point(0, p[1]);

	noFill(); strokeWeight(1.5);
	rect(0,0,width*0.45, height*0.45);
	popMatrix();

	//-- Panel 3
	cc = #177e89;
	pushMatrix();
	translate( width*0.25, height*0.75 );
	fill(cc); textSize(30); stroke(cc); textAlign(CENTER);
	text("X Movement", xoff , height*0.2);
	strokeWeight(8); point(p[0], 0);

	noFill(); strokeWeight(1.5);
	rect(0,0,width*0.45, height*0.45);
	popMatrix();

	//-- Panel 4
	cc = #57cc99;
	pushMatrix();
	translate( width*0.75, height*0.75 );
	fill(cc); textSize(30); stroke(cc); textAlign(CENTER);
	text("Full Shape", xoff , height*0.2);
	strokeWeight(8); point( p[0], p[1] );

	noFill(); strokeWeight(1.5);
	rect(0,0,width*0.45, height*0.45);
	popMatrix();

  	rectMode(CORNER);
}
