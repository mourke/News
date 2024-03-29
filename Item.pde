import java.util.Date;

public class Item {
  private ArrayList<Integer> kids;
  private Date releaseDate;
  private Integer id;
  private String author;
  private Type type;

  public Integer[] kids() {
    return kids.toArray(new Integer[kids.size()]);
  }

  public ArrayList<Comment> matchingComments(ArrayList<Comment> comments) {
    ArrayList<Comment> matching = new ArrayList<Comment>();
    for (Comment comment : comments) {
      if (kids.contains(comment.id())) {
        matching.add(comment);
        matching.addAll(comment.matchingComments(comments));
      }
    }
    return matching;
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

  String removeHTMLCodes(String dirtyString) {
    return dirtyString.replace("&#32;", " ")
      .replace("&#33;", "!")
      .replace("&#34;", "\"")
      .replace("&#35;", "#")
      .replace("&#36;", "$")
      .replace("&#37;", "%")
      .replace("&#38;", "&")
      .replace("&#39;", "\'")
      .replace("&#40;", "(")
      .replace("&#41;", ")")
      .replace("&#42;", "*")
      .replace("&#43;", "+")
      .replace("&#44;", ",")
      .replace("&#45;", "-")
      .replace("&#46;", ".")
      .replace("&#47;", "/")
      .replace("&#48;", "0")
      .replace("&#49;", "1")
      .replace("&#50;", "2")
      .replace("&#51;", "3")
      .replace("&#52;", "4")
      .replace("&#53;", "5")
      .replace("&#54;", "6")
      .replace("&#55;", "7")
      .replace("&#56;", "8")
      .replace("&#57;", "9")
      .replace("&#58;", ":")
      .replace("&#59;", ";")
      .replace("&#60;", "<")
      .replace("&#61;", "=")
      .replace("&#62;", ">")
      .replace("&#63;", "?");
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
    Long unixTime = dictionary.getLong("time");
    this.releaseDate = new Date(unixTime * 1000);
    this.author = removeHTMLCodes(dictionary.getString("by"));
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
