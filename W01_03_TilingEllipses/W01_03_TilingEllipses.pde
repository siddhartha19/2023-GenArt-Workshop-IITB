/*-----------------------------------------------------------------------
                      Author: Siddhartha Mukherjee 
                Generative Algorithms for Art & Design
            Workshop week at IDC School of Design, IITB, 2023

Instead of lines, we use the same idea to draw ellipses. Since monotonous 
ellipses might not be too interesting, we add a simple variations - circles 
transitioning into ellipses as we move down in space. This adds "dimensionality" 
to the work. As a further effect, we add a "drop-shadow" like stroke effect
to give the work a more painterly feel.
---------------------------------------------------------------------------*/

int step = 25;
float border = 50.0;

color [] colorList = { #f6bd60, #f7ede2, #f5cac3, #84a59d, #f28482 };
float ns = 0.006;
int saveID = 0;

void setup() {
  size(800,800);
  pattern();
}

void draw() { }

void mousePressed() {
  //-- Left mouse press will regenerate the sketch, right press will save a new image with each click
  if(mouseButton==LEFT) {
    pattern();
  } else {
    save("../03-EllipseTiling-" + nf(saveID, 2) + ".png");
    saveID++;
  }
}

void pattern() {
  background( colorList[ int(random(colorList.length)) ] );
  
  //-- Some random numbers we will multiply with our playful sin and cos functions
  float k1 = random(-1,1)*2, k2 = random(-1,1), k3 = random(-1,1)*0.2;
  
  for( float i=border; i<width-border; i+=step ) {
    for( float j=border; j<height-border; j+=step ) {

      pushMatrix();

      translate(i+step*0.5, j+step*0.5);
       float noiseVal = noise( i*ns, j*ns );
      
      float theta = (sin(i*j*TWO_PI*k1/height/width) * cos(k2*(i-j)*TWO_PI/width) - sin(i*k3*TWO_PI/width) + tan(i*TWO_PI*k2/width))*PI; 
      rotate(theta);
      
      //-- As an example, also using the noise value here to set the strokeWeight
      strokeWeight( noiseVal*5.0 );

      //-- We are picking stroke and fill colours as some functions again of i and j, Note the % or mod operator - it gives the remainder part upon division, so mod(5,7) = 5 while mod(7,5) = 2
      stroke( colorList[ int(i*j/width)%colorList.length ], 250 );
      noFill();
      float rad1Frac = (1.0-j*0.8/height);
      ellipse( 0, 0, 0.8*step*rad1Frac, 0.8*step );

      fill( colorList[ int(i*j*2.0/width)%colorList.length ], 250 );
      noStroke();
      ellipse( random(-3,3)*rad1Frac, random(-3,3)*rad1Frac, 0.8*step*rad1Frac + random(-1,1)*rad1Frac*4.0, 0.8*step + random(-1,1)*rad1Frac*4.0 );
     
      popMatrix();
    }
  }
}
