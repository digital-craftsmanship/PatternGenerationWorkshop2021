//Inspiration, data and formgiving: Stefanie and Gioria Lupi (www.dear-data.com)
//and the lecture DCB150W1_workingwithdata by Janet Huang slide 11
//The programs reads the data from a text file and generates a visualisation.
//Code (c) Loe Feijs 2021 for course Digital Craftsmanship

import processing.pdf.*;
String fileName = "week15";
ArrayList<Activity> activities = new ArrayList<Activity>();

void setup(){
     beginRecord(PDF, fileName + ".pdf");
     size(800,500);//eg 800,500
     colorMode(HSB,100);
     activities = parseFile(fileName + ".txt");
     doPlacement(activities);
     noLoop();
}

void draw(){
     background(0,0,100);
     for (Activity a : activities){
          a.draw();
     }
     endRecord();
}

void doPlacement(ArrayList<Activity> activities){
     //this works by backtracking, finding positions for each activity's drawing,
     //so they do not (or not too much) overlap; do not change the fan of leaf lines
     
     for (int i = 0; i < activities.size(); i++){
          Activity a = activities.get(i); //now try to fix this a
          boolean collision = true;       //true, to get loop going

          for (int go = 0; collision && go < 1000; go++) {
               //throw dice for new position, < 1000 times
               a.rePosition();
               collision = false;
               
               //a to be tested  against all earlier b
               for (int j = 0; j < i; j++){
                    Activity b = activities.get(j);
                    collision = collision || a.collides(b);
               }
          }
     }
}
