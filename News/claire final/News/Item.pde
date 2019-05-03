import java.util.Date;

public class Item {
  private ArrayList<Integer> kids;
  private Date releaseDate;
  private Integer id;
  private String author;
  private Type type;
  public Long unixTime;

  public Integer[] kids() {
    return kids.toArray(new Integer[kids.size()]);
  }

  public Date releaseDate() {
    return releaseDate;
  }

  public Integer id() {
    return id;
  }

  public String author() {
    return author;
  }

  public Type type() {
    return type;
  }
  
  public int getTime(){
    //return unixTime;
   return Math.toIntExact(unixTime); 
  }
  


  Item(ArrayList<Integer> kids, 
    Date releaseDate, 
    Integer id, 
    String author, 
    Type type) {
    this.kids = kids;
    this.releaseDate = releaseDate;
    this.id = id;
    this.author = author;
    this.type = type;
  }

  Item(JSONObject dictionary) throws Exception {
    this.kids = new ArrayList<Integer>();
    try {
      JSONArray kidsArray = dictionary.getJSONArray("kids");
      for (int i = 0; i < kidsArray.size(); ++i) {
        kids.add(Integer.valueOf(kidsArray.getInt(i)));
      }
    } 
    catch (NullPointerException e) {
    }
    unixTime = dictionary.getLong("time");
    this.releaseDate = new Date(unixTime * 1000);
    this.author = dictionary.getString("by");
    this.id = dictionary.getInt("id");
    String typeString = dictionary.getString("type");

    if (typeString.equals("story")) {
      this.type = Type.STORY;
    } else if (typeString.equals("comment")) {
      this.type = Type.COMMENT;
    } else {
      throw new Exception("Unreconised value in 'type' field");
    }
  }
}