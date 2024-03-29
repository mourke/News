import  java.util.Date;

class Comment extends Item {
  private Integer parentId;
  private String text;
  
  public String text() {
    return text;
  }
  
  public Integer parentId() {
    return parentId;
  }

  Comment(Integer parentId, 
    String text, 
    ArrayList<Integer> kids, 
    Date releaseDate, 
    Integer id, 
    String author, 
    Type type) {
    super(kids, releaseDate, id, author, type);
    this.parentId = parentId;
    this.text = text;
  }
  
  Comment(JSONObject dictionary) throws Exception {
    super(dictionary);
    this.parentId = Integer.valueOf(dictionary.getInt("parent"));
    this.text = removeHTMLCodes(dictionary.getString("text"));
  }
}
