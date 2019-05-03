import java.io.*; 
import java.util.*;
import java.text.*;
class timeFilter /*extends Widget*/ {
  int firstAvailableDate;
  int lastAvailableDate;
  int dayLength = 86400;
  int weekLength = 604800;
  int yearLength =  31557600;
  java.util.Date time;
  java.util.Date time2;
  java.util.Date time3;
  java.util.Date time4;
  java.util.Date time5;
  int weeksLeftInFirstYear;
  int weeksAfterStartOfLastYear;
  double weekAmountWithExtra;
  double weekWithoutExtra;
  int weeksSinceStartOfYear;
  int weeksTillEndOfYear;
  String weekday = "";

  public timeFilter(ArrayList<Story> storiesList) {
    int tempStartDate = 0;
    int tempEndDate = 0;
    Story tempStory1 = storiesList.get(0);
    tempStartDate = tempStory1.getTime();
    for (int index = 1; index < storiesList.size(); index++) {
      tempStory1 = storiesList.get(index);
      if (tempStartDate >= tempStory1.getTime()) {
        tempStartDate = tempStory1.getTime();
      }

      if (tempEndDate <= tempStory1.getTime()) {
        tempEndDate = tempStory1.getTime();
      }
    }
    this.firstAvailableDate = tempStartDate - (tempStartDate % dayLength);
    
    this.lastAvailableDate = tempEndDate - (tempEndDate % dayLength);
    time3=new java.util.Date((long)getFirstDayOfWeek(lastAvailableDate)*1000);
   
    weeksSinceStartOfYear  = getAmountOfWeeks(discardYear(getFirstDayOfWeek(lastAvailableDate)));
    weeksTillEndOfYear = getRestOfWeeks(discardYear(getFirstDayOfWeek(lastAvailableDate)));
    

   
  }

  void printTime() {
    System.out.println(weekday);
     println(getFirstDayOfWeek(lastAvailableDate));
    println(time);
    println(weeksSinceStartOfYear);

  }
  int getFirstDayOfWeek(int timeToCheck){
    
    SimpleDateFormat sdf = new SimpleDateFormat("E");
    Date dateFormat = new java.util.Date((long)timeToCheck*1000);
   
    weekday = sdf.format(dateFormat);
   
    switch(weekday) {

    case "Mon":
   
    return timeToCheck;
     

    case "Tue":
     
      return timeToCheck - (dayLength);
      

    case "Wed":
   
      return timeToCheck - (dayLength*2);
     

    case "Thu":
    
      return timeToCheck - (dayLength*3);

      
    case "Fri":
   
      return timeToCheck - (dayLength*4);

     
    case "Sat":
     
     
      return timeToCheck - (dayLength*5);
      
    case "Sun":
     
      return timeToCheck - (dayLength*6);

     
    }
    
    
   return timeToCheck; 
  }
  
  int getAmountOfWeeks(int secondsSinceStartOfYear){
    return secondsSinceStartOfYear / weekLength;
    
  }
  
  int getRestOfWeeks(int secondsSinceStartOfYear){
   return (yearLength - secondsSinceStartOfYear) / weekLength;
    
  }
  int discardYear(int totalSeconds){
    
   return totalSeconds % yearLength; 
  }
  
  int startTime(int year, int week){
    
    int time = (year - 1970) * yearLength;
    time = time +(week * weekLength) +dayLength;
    println(time);
    return time;

  }

}