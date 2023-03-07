/*------------------------------------------------------------
                Author: Siddhartha Mukherjee 
           Generative Algorithms for Art & Design
      Workshop week at IDC School of Design, IITB, 2023

A very basic Truchet tiling to generate a maze-like pattern
-------------------------------------------------------------*/

color [] colorList = { #f6bd60, #f7ede2, #f5cac3, #84a59d, #f28482 };
int step = 20; //-- Change step size   
float rf = 0.4; //-- Change random fraction

void setup() {
  size(500,500);
  pattern();
  save("../01-Truchet.png");
}

void pattern() {
  //-- We pick a random color from the list/array of colors
  background( colorList[ int(random(colorList.length)) ] );
  strokeWeight(2.0); 
  for(int i=0; i<width; i+=step) {
    for( int j=0; j<height; j+=step ) {
      stroke( colorList[ int(random(colorList.length)) ] );
      if(random(1) < rf) {
        line( i, j, i+step, j+step );
      } else {
        line( i, j+step, i+step, j );
      }
    }
  }
}
