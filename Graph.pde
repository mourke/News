import java.io.*;  //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
import java.util.*;
class Graph /*extends Widget*/ {
  private ArrayList <Story> storyArray;
 // private ArrayList <Graph> graphArray;
  int[] highestScoreOrder = new int[5];
  int placeInOrder;
  private Map<Long, Item> mainMap=new TreeMap<Long, Item>();
  int chart[];
  int s;
  int timeB;
  int timeA;
  int barX = 100;
  int amountOfdays;
  int widthOfbars;
  Story ArrayOfHighStorys[];
  int chartPosArray[][];
  int startingTime;
  int lengthOfDay = 86400;
  boolean chartBarClicked = false;
  boolean executed = false;
  ArrayList <Integer> rndmColours;
  int IndexClicked;

  public Graph( int timeTakenIn, ArrayList<Story> storyArray) {    
    //super(xpos, ypos, WIDGET_HEIGHT, WIDGET_WIDTH, color(255), color(0), label, event);
    //this.graphArray = graphArray;
    this.storyArray = storyArray;
    this.mainMap = mainMap;
    int window = 7;
    /* 
     TestValues
     1160418111
     1160423503
     */
    this.startingTime = timeTakenIn;
    chart = new int[window];
    amountOfdays = window;
    //  test = new long[window];
    ArrayOfHighStorys = new Story[5];
    chartPosArray = new int[window][4];
    rndmColours = new ArrayList<Integer>();
  }

 // @Override
    public void draw () {

    int NewDayToCheck = 0;
    textSize(11);
    fill(255);
   // text(label(), xpos(), ypos());
    widthOfbars = (int) (200 / 7)+6;
    int currentDay = startingTime;
    //int barY = 600;
    fill(0, 0, 0);
    textFont(titleFont);
    textSize(15);
    text(" Pie Chart of active story posters.", 68, 100, 600, 50);
    text(" Bar Chart of frequency of daily stories.", 425, 25, 600, 50);
    text(" Bar Chart of top scoring users.", 375, 710, 600, 50);



    //Start of Daily Frequency Graph 
    int tempDateToCheck = currentDay;
    for (int index = 0; index < chart.length; index++) {


      chart[index] = this.getHeight(storyArray, tempDateToCheck);
      tempDateToCheck = tempDateToCheck + lengthOfDay ;
    }


    barX = 500;
    int barY = 400;
    int count = 0;
    textFont(captionFont);
    textSize(12);
    for (int idx= 0; idx<chart.length; idx++) {
      fill(#008080);
      int currentYpos = barY-80-(chart[idx]*2);
      rect(barX, currentYpos, widthOfbars, chart[idx]*2);
      if (chart[idx] == 1) {
        text(chart[idx]+ " Story ", barX-(widthOfbars/2)-30, barY-70, 150, 50);
      } else {
        text(chart[idx]+ " Stories ", barX-(widthOfbars/2)-30, barY-70, 150, 50);
      }
      text(("day "+(idx+1)), barX-(widthOfbars/2)-30, barY-40, 150, 50);
      if (count < chartPosArray.length) {
        chartPosArray[count][0] = barX;
        chartPosArray[count][1] = widthOfbars;
        chartPosArray[count][2] = currentYpos;
        chartPosArray[count][3] = chart[idx] *2 ;
        count++;
      }




     
      barX += widthOfbars*2;
    }





    //End of Daily Frequency Graph
    //if (chartBarClicked) {
    currentDay = startingTime + (IndexClicked * lengthOfDay);
    //  }


    //Start Of Highest Score Graph
    getHighestScores(storyArray, currentDay);
    barY = 750;
    barX = 500;
    widthOfbars = (int) 200 / 5;
    //   if(ArrayOfHighStorys[0] != null){
    for (int tempInxed = 0; tempInxed < ArrayOfHighStorys.length; tempInxed++) {
      fill(255, 0, 0);
      int currentBarYPos = barY-80-( getScoreHeight( storyArray, tempInxed) *2);
      rect(barX, currentBarYPos, widthOfbars, getScoreHeight( storyArray, tempInxed) *2);
      fill(70, 70, 70);
      text(("score "+(getScoreHeight( storyArray, tempInxed))), barX-(widthOfbars/2)-30, barY-70, 150, 50);

      text(("A: " +(getAuthor( storyArray, tempInxed))), barX-(widthOfbars)-140, barY-60, 400, 50);

      barX += widthOfbars*2;
    }
  

    //End Of Highest Score Graph

    //Pie Chart

    pieGraph(storyArray, currentDay);
  }

  int[][] getChartArray() {

    return chartPosArray;
  }

  void getChartState(boolean currentState, int clickedIndex) {
    this.chartBarClicked = currentState;
    this.IndexClicked = clickedIndex;
  }

  int getHeight(ArrayList<Story> storyArray, int timeA) {
    int freqCount = 0;
    timeB = timeA + lengthOfDay ;
    int i = 0;
    for (i = 0; i < storyArray.size(); i++) {
      Story tempStory = storyArray.get(i);

      if (tempStory.releaseDate().getTime() >= timeA && tempStory.releaseDate().getTime() <= timeB) {
        freqCount++;
      }
    }
    return freqCount;
  }

  void getHighestScores(ArrayList<Story> storyArray, int timeD) {
    boolean full = false;
    int count = 0;
    int tempIndex = 0;
    placeInOrder = 5;
    int timeC = timeD + lengthOfDay;
    for (tempIndex = 0; tempIndex < storyArray.size(); tempIndex++) {
      Story tempStory1 = storyArray.get(tempIndex);
      if (tempStory1.releaseDate().getTime() >= timeD && tempStory1.releaseDate().getTime() <= timeC) {
        if (count == 5) {
          full= true;
          break;
        }
        ArrayOfHighStorys[count] = tempStory1;
        count++;
      }
     
    }
    if (full == true) {
      Arrays.sort(ArrayOfHighStorys);

      for (int index = tempIndex; index < storyArray.size(); index++) {
        Story tempStory2 = storyArray.get(index);
        if (tempStory2.releaseDate().getTime() >= timeD && tempStory2.releaseDate().getTime() <= timeC) {
          if (tempStory2.score() > ArrayOfHighStorys[4].score()) {
            ArrayOfHighStorys[4] = tempStory2;
            Arrays.sort(ArrayOfHighStorys);
          }
        }
      }
    } else if (full == false && count != 0) {
      for (int filler = count; filler< ArrayOfHighStorys.length; filler++) {
        ArrayOfHighStorys[filler] = null;
      }
      for (int index = tempIndex; index < storyArray.size(); index++) {
        Story tempStory2 = storyArray.get(index);
        if (tempStory2.releaseDate().getTime() >= timeD && tempStory2.releaseDate().getTime() <= timeC) {
          if (tempStory2.score() > ArrayOfHighStorys[count].score()) {
            ArrayOfHighStorys[count] = tempStory2;
            Arrays.sort(ArrayOfHighStorys);
          }
        }
      }
    } else {
      for (int filler = count; filler< ArrayOfHighStorys.length; filler++) {
        ArrayOfHighStorys[filler] = null;
      }
    }
  }

  void pieGraph(ArrayList<Story> storyArray, int timeA) {
     textFont(textFont);
    //ArrayList<Integer> test = new ArrayList<Integer>();
    int nextDay = timeA + 86400;
    ArrayList<String> authorList = new ArrayList<String>();
    HashMap<String, Integer> authorFreq = new HashMap<String, Integer>();
    for (int index = 0; index < storyArray.size(); index++) {
      Story tempStory1 = storyArray.get(index);

      if (tempStory1.releaseDate().getTime() >= timeA && tempStory1.releaseDate().getTime() <= nextDay) {

        if (authorFreq.containsKey(tempStory1.author() ) ) {

          int tempCounter = authorFreq.get(tempStory1.author());
          tempCounter += 1;
          authorFreq.put(tempStory1.author(), tempCounter);
        } else {

          int initCount = 1;
          authorList.add(tempStory1.author());
          authorFreq.put(tempStory1.author(), initCount);
        }
      }
    }
    int total = 0;
    for (int tempIndex = 0; tempIndex < authorList.size(); tempIndex++) {
      String authorKey = authorList.get(tempIndex);
      int temp = authorFreq.get(authorKey);
      //  println(temp);
      total = total + temp;
    }
    //if(authorList.size()>15){
    //   int[] arrayToBeOrdered = new int[authorList.size()];
    //   for(){
    //    arrayToBeOrdered[x] =  authorFreq.get(authorList.get(x)):
    //   }
      
      
    //}
    int[] angles = new int[authorList.size()];
    ArrayList <Integer> anglePercents = new ArrayList<Integer>();
    String[] angleLabels = new String[authorList.size()];
    ArrayList <String> authorsToNotUse = new ArrayList<String>();
    int count = 0;
    int counter = 0;
    for (int tempIndex = 0; tempIndex < authorList.size(); tempIndex++) {
      String authorKey = authorList.get(tempIndex);
      int temp = authorFreq.get(authorKey);
      double total2 = (double) total;
      double temp2 = (double) temp;    
      double secondTemp = (double)temp2 / total2;

      double tempNumber4 = secondTemp*100;



      int percentageToBe = (int) tempNumber4;
      int flLabelToConvert = percentageToBe;
      anglePercents.add(flLabelToConvert); //<>//
      String tempLabel = Integer.toString(flLabelToConvert); //<>//
      angleLabels[tempIndex] =  tempLabel;
      float doubleAngleToBeStored = (float)secondTemp * 360;
      long angleTobeStored =  Math.round(doubleAngleToBeStored);
      int sizeChecker = authorList.size();

      angles[tempIndex] =  (int) angleTobeStored;
      if(anglePercents.size() >=15){ //<>//
        if(anglePercents.get(tempIndex - counter) < 2  ){ //<>//
         anglePercents.remove(tempIndex -counter);
         authorsToNotUse.add(authorList.get(tempIndex - counter));
         
         
         counter++;
         
      }
        
        
      }
     
      
       
    }


    float lastAngle = 0;
    int labelCheckIndex = 0;
    for (int i = 0; i < angles.length; i++) {
      int arrayLength = angles.length;


    //  if (executed == false) {
        for (int j = 0; j <= angles.length+2; j++) {

          color test = color(random(255), random(255), random(255));
          rndmColours.add(test);
        } 
     //   executed = true;
   //   }
   


      fill(rndmColours.get(i));
      float xpos = 200;
      float ypos = 250;
      float diameter = 250;
      stroke(255);
      arc(xpos, ypos, diameter, diameter, lastAngle, lastAngle+radians(angles[i]));
      noStroke();
     if(i < anglePercents.size() && i < authorsToNotUse.size()){
       
       if(!authorList.get(i).equals(authorsToNotUse.get(i))){
         text("*"+(i+1)+":Author: " + authorList.get(i)+":"+ anglePercents.get(i)+"%", 200, 400 + 15*i);
         
       }
         
     }
      
     
      lastAngle += radians(angles[i]);
    }
  }

  int getScoreHeight(ArrayList<Story> storyArray, int index) {
    if (ArrayOfHighStorys[index] == null) {
      return 0;
    } else return ArrayOfHighStorys[index].score();
  }
  String getAuthor(ArrayList<Story> storyArray, int index) {
    if (ArrayOfHighStorys[index] == null) {
      return "";
    } else  return ArrayOfHighStorys[index].author();
  }
  Date getStartingDate() {
    return new Date(startingTime * 1000);
  }
  Date getEndDate() {
    return new Date(timeB * 1000);
  }
}
