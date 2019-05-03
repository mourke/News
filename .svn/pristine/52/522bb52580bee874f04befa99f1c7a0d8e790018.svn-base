class User {

  private String username;
  private ArrayList<Story> userStories;
  private ArrayList<Comment> userComments;
  private int topScore;
  private int numContributions;
  private Date lastActivity;            // may be null
  private PImage pic;

  public User(String username) {
    this.username = username;

    userStories = getStoriesByUsername(stories, username);
    userComments = getCommentsByUsername(comments, username);

    topScore = getTopScore(userStories);
    lastActivity = findLastActivity(userStories, userComments);
    numContributions = getNumContributions(userStories, userComments);
    pic = choosePic();
  }

  public String username() {
    return username;
  }

  public ArrayList<Story> stories() {
    return userStories;
  }

  public ArrayList<Comment> comments() {
    return userComments;
  }
  
  public int topScore() {
    return topScore;
  }
  
  public int numContributions() {
    return numContributions;
  }
  
  public Date lastActivity() {
    return lastActivity;
  }

  public int getTopScore(ArrayList<Story> stories) {
    if (stories.size() == 0) {
      return 0;
    }
    int record = 0;
    for (Story s : stories) {
      try {
        if (s.score > record) {
          record = s.score;
        }
      } 
      catch (Exception e) {
        println("No score for user "+username+" on story "+s.id());
      }
    }
    return record;
  }

  public Date findLastActivity(ArrayList<Story> userStories, ArrayList<Comment> userComments) {
    //Long l = 1546300800*1000;                          // arbitrary time in 2019
    Date latest = new Date(0);
    println(latest);
    for (Story s : userStories) {
      try {
        if (s.releaseDate().after(latest)) {
          latest = s.releaseDate();
        }
      } 
      catch (Exception e) {
        println("No date for item "+s.id());
      }
    }
     for (Comment c : userComments) {
      try {
        if (c.releaseDate().after(latest)) {
          latest = c.releaseDate();
        }
      } 
      catch (Exception e) {
        println("No date for item "+c.id());
      }
    }
    if (latest.equals(new Date(0))) {
      return null;  // wasnt updated
    } else {
      return latest;
    }
  }
  
  public int getNumContributions(ArrayList<Story> userStories, ArrayList<Comment> userComments) {
    return userStories.size() + userComments.size();
  }
  
  public PImage choosePic() {
    if (topScore > 50) {
      return gold;
    } else if (topScore > 20) {
      return silver;
    } else {
      return bronze;
    }
  }
  
  public PImage pic() {
    return pic;
  }
}
