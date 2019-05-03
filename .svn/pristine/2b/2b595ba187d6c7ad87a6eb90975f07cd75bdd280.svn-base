import java.io.*;  //<>// //<>// //<>//
import java.util.*;
import java.text.*;

class timeFilter /*extends Widget*/ {
  long firstAvailableDate;
  long lastAvailableDate;
  int dayLength = 86400;
  int weekLength = 604800;
  int yearLength =  31557600;
  Date time;
  Date time2;
  Date time3;
  Date time4;
  Date time5;
  int weeksLeftInFirstYear;
  int weeksAfterStartOfLastYear;
  double weekAmountWithExtra;
  double weekWithoutExtra;
  int weeksSinceStartOfYear;
  int weeksTillEndOfYear;
  String weekday = "";

  public timeFilter(ArrayList<Story> storiesList) {
    long tempStartDate = 0;
    long tempEndDate = 0;
    Story tempStory1 = storiesList.get(0);
    tempStartDate = tempStory1.releaseDate().getTime();
    for (int index = 1; index < storiesList.size(); index++) {
      tempStory1 = storiesList.get(index);
      if (tempStartDate >= tempStory1.releaseDate().getTime()) {
        tempStartDate = tempStory1.releaseDate().getTime();
      }

      if (tempEndDate <= tempStory1.releaseDate().getTime()) {
        tempEndDate = tempStory1.releaseDate().getTime();
      }
    }
    this.firstAvailableDate = tempStartDate - (tempStartDate % dayLength);

    this.lastAvailableDate = tempEndDate - (tempEndDate % dayLength);
    time3=new Date(getFirstDayOfWeek(lastAvailableDate)*1000);

    weeksSinceStartOfYear  = getAmountOfWeeks(discardYear(getFirstDayOfWeek(lastAvailableDate)));
    weeksTillEndOfYear = getRestOfWeeks(discardYear(getFirstDayOfWeek(lastAvailableDate)));
  }

  void printTime() {
    System.out.println(weekday);
    println(getFirstDayOfWeek(lastAvailableDate));
    println(time);
    println(weeksSinceStartOfYear);
  }
  long getFirstDayOfWeek(long timeToCheck) {

    SimpleDateFormat sdf = new SimpleDateFormat("E");
    Date dateFormat = new Date(timeToCheck*1000);

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

  int getAmountOfWeeks(long secondsSinceStartOfYear) {
    return int(secondsSinceStartOfYear / (long)weekLength);
  }

  int getRestOfWeeks(long secondsSinceStartOfYear) {
    return int(yearLength - secondsSinceStartOfYear) / weekLength;
  }
  long discardYear(long totalSeconds) {

    return totalSeconds % yearLength;
  }

  int startTime(int year, int week) {

    int time = (year - 1970) * yearLength;
    time = time +(week * weekLength) +dayLength;
    println(time);
    return time;
  }
}
