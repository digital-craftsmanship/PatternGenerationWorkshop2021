//An activity is an object with a title and a duration.
//The challenge is to have a nice graphical representation: a stem and a fan of leaf lines
//The stem goes vertically, the highest point being screen coordinates x and y.
//The leaf lines sprout from x,y, the length and direction being coded as PVector.
//The duration of the activity determines the number of leaf lines (60*hours + minutes) / 20)

class Activity {
      String title;             //data
      int hours;                //data
      int minutes;              //data
      color clr;                //color
      float x;                  //screen coordinate
      float y;                  //idem
      ArrayList<PVector> lines; //visualisation
      Activity(String t, int h, int m){
               title = t;
               hours = h;
               minutes = m;
               //choose soft/pastel hue, saturation, brightness
               clr = color(floor(random(100)),75,80);
               x = 0; //use rePosition later
               y = 0; //idem
               lines = new ArrayList<PVector>();
               doLayout();//create the lines
      }
      void rePosition(){
           //throw dice to put the drawing at random position,
           //yet make sure to stay within the screen boundaries
           x = random(35,width - 35);
           y = random(150,height - 15);
      }
      void doLayout(){
           //make a nice fan of leaf lines
           int branches = (60*hours + minutes) / 20;//number of leaf lines
           float dphi = radians(2);                 //rotational spacing is 2 degrees
           float phi = -(branches / 2) * dphi;      //initial angle phi chosen to make fan symmetric
           for (int i = 0; i < branches; i++){
 
                float len = 150;                    //initial idea: all leaf lines equally long
                len = len - 20*noise(0.1*i,phi);    //yet subtract a bit of Perlin noise
                len = len - 75*abs(sin(phi/2));     //and reduce the length for extreme angles
                PVector line = new PVector(0,-len); //note: negative y means going upward
                
                phi = phi + dphi;
                line.rotate(phi);
                lines.add(line);
           }  
      }
      boolean collides(Activity b){
              //find out whether some of this's lines intersect some of b's lines
              //use the "intersects" routine as proposed by Paul Bourke.
              //Test ALL lines of this against all lines of b.
              //First test test this' leaf lines against b's leaf lines,
              //then this' stem against b's leaf lines,
              //and then the leaf lines of this against the stem of b,
              //finally stem-stem (not intersect, test distance)
              boolean aha = false;
              for (PVector l1 : this.lines){
                   for (PVector l2 : b.lines){
                        if (  intersects(x,y,x+l1.x,y+l1.y,b.x,b.y,b.x+l2.x,b.y+l2.y)
                           || intersects(x,y,x,height,b.x,b.y,b.x+l2.x,b.y+l2.y)
                           || intersects(x,y,x+l1.x,y+l1.y,b.x,b.y,b.x,height) 
                           || abs(x - b.x) < 5
                           )  aha = true;
                   }
              }
              return aha;
      }
      void stitch(){
           //like draw, but avoids jumps, no text,
           //convert by Illustrator to .svg(1.0), 
           //Then use Brother PEDesign
           noFill();
           stroke(clr);
           beginShape();
           vertex(x,y);
           vertex(x,height);
           vertex(x,y);
           for (PVector l : lines){   
                vertex(x + l.x,y + l.y);
                vertex(x,y);
           }
           endShape();
      }
      void draw(){
           //put it on screen
           stroke(clr);
           strokeWeight(1.6);
           line(x,y,x,height);         //stem of the tree
           for (PVector l : lines){    //loop through its leaf lines
                strokeWeight(1 + random(1));                              //simulate pen variation
                //line(x,y,x + l.x,y + l.y);                              //this would be technically correct
                line(x + random(-2,2),y + random(-2,2),x + l.x,y + l.y);  //but we add some aesthetic noise
           }
           fill(clr);
           textSize(16); 
           text(title,x - 4*title.length(),y - 150);
      }
      void lpr(){
           //put it on line printer
           println(title + " " + hours + ":" + minutes); 
      }
}
