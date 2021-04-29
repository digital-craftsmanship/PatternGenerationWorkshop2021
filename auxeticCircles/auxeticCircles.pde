/*making circle segments for an auxetic structure*/
/*Loe Feijs for Digital Craftsmanship 2020@TU/e  */

void setup(){
     strokeWeight(20);
     size(800,800);
     smooth();
     noFill();
     noLoop();
}
int cx = 400;
int cy = 400;//globals, use in segment

void draw(){
     int R = 100;
     segment(R,0,45);
     segment(R,90,135);
     segment(R,180,225);
     segment(R,270,315);
     R = 200;
     for (int i = 0; i < 36; i = i+2)
          segment(R,10*i,10*(i+1.4));
          //18 segments of 14 degrees each
               for (int i = 0; i < 36; i = i+2)
     R = 230;
     for (int i = 0; i < 36; i = i+2)
     segment(R,10 + 10*i,10 + 10*(i+1.4));
          //18 segments of 14 degrees each, shifted
}

void segment(float R, float from, float to){
     //R is radius, from and to are angles in degrees
     beginShape();
     for (float phi = radians(from); phi <= radians(to); phi+=PI/180){
          curveVertex(cx + R*cos(phi),cy + R*sin(phi));
       
     }    //end for
     endShape();
}
