//The file parser is adapted from https://processing.org/reference/createReader_.html
//It is akind of csv file, but here we have space and : as separators, so for example:
//SLEEPING 50:31
//WORKING 27:03
//TRAVELLING 16:12 and so on

ArrayList<Activity> parseFile(String fullname) {
          //Open the file which has lines, each having String space int colon int
          //store them in a global arraylist activities
          BufferedReader reader = createReader(fullname);
          String line = null;
          try {
            activities = new ArrayList<Activity>();
            while ((line = reader.readLine()) != null) {
                   String[] pieces = splitTokens(line, " :");
                   String title = pieces[0];
                   int hours = int(pieces[1]);
                   int minutes = int(pieces[2]);
                   Activity a = new Activity(title,hours,minutes);
                   activities.add(a);
            }
            reader.close();
            return activities;
          } catch (IOException e) {
            println("OOPS, reading file failed");
            e.printStackTrace();
            return null;
          }
} 
