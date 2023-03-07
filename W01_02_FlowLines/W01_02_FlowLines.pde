/*----------------------------------------------------------------
                Author: Siddhartha Mukherjee 
          Generative Algorithms for Art & Design
      Workshop week at IDC School of Design, IITB, 2023

Instead of tiling, we now draw short lines at each subdivision
point in space, leading to a more "flow" like aesthetic. This
is also the first step towards building a digital/analogue 
display, where the spatial variation will encode some information.
-----------------------------------------------------------------*/

color [] colorList = { #f6bd60, #f7ede2, #f5cac3, #84a59d, #f28482 };
int step = 10;
float ns = 0.004; //-- Noise scaling

void setup() {
  size(500,500);
  pattern();  
  save("../02-Flows.png");
}

void pattern() {
  //-- We pick a random color from the list/array of colors
  background( colorList[ int(random(colorList.length)) ] );
  float k1 = random(-1,1)*2, k2 = random(-1,1), k3 = random(-1,1)*0.2;
  
  for(int i=0; i<width; i+=step) {
    for( int j=0; j<height; j+=step ) {
      stroke( colorList[ int(random(colorList.length)) ] );
      pushMatrix();
      translate(i+step*0.5, j+step*0.5);

      //-- It's generally useful to save the local noise value at i,j in a variable, which can be used in multiple ways later
      float noiseVal = noise( i*ns, j*ns ); rotate(noiseVal*TWO_PI); 

      //-- You can play with your own sin and cos formulas to generate new patterns instead. Comment the line below to use the Noise based variations above
      float theta = (sin(i*j*TWO_PI*k1/height/width) * cos(k2*(i-j)*TWO_PI/width) - sin(i*k3*TWO_PI/width) + tan(i*TWO_PI*k2/width))*PI; rotate(theta);
      
      //-- As an example, also using the noise value here to set the strokeWeight
      strokeWeight( noiseVal*5.0 );
      line( 0, -step*0.5, 0, step*0.5 );
      popMatrix();     
    }
  }
}
