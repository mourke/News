import java.net.URL; 
import java.util.Date;
import java.util.Optional;
import java.net.URL; 
import java.util.Date;
import java.util.Optional;

class Story extends Item implements Comparable<Story>{
  private Integer numberOfComments;
  private Optional<URL> url;
  private String title;
  private Integer score;

  public Integer numberOfComments() {
    return numberOfComments;
  }

  public Optional<URL> url() {
    return url;
  }

  public String title() {
    return title;
  }

  public Integer score() {
    return score;
  }
  
   public int compareTo(Story storyToCompare) {
  
    int compareQuantity = ((Story) storyToCompare).score(); 
    
    //ascending order
    //return this.score - compareQuantity;
    
    //descending order
    return compareQuantity - this.score;
    
  }  
  
 

  Story(Integer numberOfComments, 
    URL url, 
    String title, 
    Integer score, 
    ArrayList<Integer> kids, 
    Date releaseDate, 
    Integer id, 
    String author, 
    Type type) {
    super(kids, releaseDate, id, author, type);
    this.numberOfComments = numberOfComments;
    this.url = Optional.of(url);
    this.title = title;
    this.score = score;
  }

  Story(JSONObject dictionary) throws Exception {
    super(dictionary);
    numberOfComments = Integer.valueOf(dictionary.getInt("descendants"));
    String urlString = dictionary.getString("url");

    if (urlString.length() == 0) {
      url = Optional.ofNullable(null);
    } else {
      url = Optional.of(new URL(urlString));
    }

    title = dictionary.getString("title");
    score = Integer.valueOf(dictionary.getInt("score"));
  }
}
