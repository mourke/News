class Label extends Widget {

  private String text;
  private PFont font;
  private color textColor;
  private float maxWidth = Float.MAX_VALUE;
  private int maxNumberOfLines = 1;
  private int textAllignmentX = LEFT;
  private int textAllignmentY = TOP;

  public Label(String text, Point origin) {
    super(new Rect(origin, new Size(0, 0)));
    setText(text);
    setBackgroundColor(color(1, 0, 0, 0));
  }
  
  public void setMaxLines(int numberOfLines) throws IllegalArgumentException {
    if (numberOfLines <= 0) throw new IllegalArgumentException("Number of lines must be greater than 0");
    this.maxNumberOfLines = numberOfLines;
    updateSize();
  }

  public void setTextAllignmentX(int textAllignmentX) {
    this.textAllignmentX = textAllignmentX;
  }

  public void setTextAllignmentY(int textAllignmentY) {
    this.textAllignmentY = textAllignmentY;
  }

  public void setMaxWidth(float maxWidth) {
    this.maxWidth = maxWidth;
    updateSize();
  }
  
  public float maxWidth() {
    return maxWidth;
  }

  private String truncateText(String text) {
    String truncatedText = "";
    String elipses = "...";
    float elipsesWidth = getTextWidth(elipses);

    for (char character : text.toCharArray()) {
      if ((getTextWidth(truncatedText + character) + elipsesWidth) >= maxWidth) break;
      truncatedText += character;
    }

    truncatedText += elipses;
    return truncatedText;
  }

  public void setText(String text) {
    this.text = ((getTextWidth(text) > maxWidth) && maxNumberOfLines == 1) ? truncateText(text) : text;
    updateSize();
  }

  public void setFont(PFont font) {
    this.font = font;
    updateSize();
  }

  public void setTextColor(color textColor) {
    this.textColor = textColor;
  }

  private void updateSize() {
    float textWidth = getTextWidth(this.text);
    frame.size.width = textWidth > maxWidth ? maxWidth : textWidth;
    int lines = numberOfFilledLines();
    float lineSpacing = (lines - 1) * 9;
    frame.size.height = (lines * getFontMaxHeight()) + lineSpacing;
  }
  
  private int numberOfFilledLines() {
    if (maxNumberOfLines == 1) return 1;
    
    String text = "";
    int lines = 1;

    String[] words = this.text.split(" ");
    for (String word : words) {
      text += word;
      if (getTextWidth(text) >= maxWidth) {
        if (lines > maxNumberOfLines) break;
        text = word;
        lines++;
      }
    }
    
    return lines;
  }

  private float getTextWidth(String text) {
    if (font != null) textFont(font); // textFont must be called so an accurate size can be calculated.
    return textWidth(text) + 1; // add 1 pixel of padding
  }

  private float getFontMaxHeight() {
    if (font != null) textFont(font); // textFont must be called so an accurate size can be calculated.
    return textAscent() + textDescent();
  }

  public String getText() {
    return this.text;
  }

  public PFont font() {
    return this.font;
  }

  public void draw() {
    if (hidden) return;

    super.draw();

    if (text.length() == 0) return;

    fill(textColor);
    if (font != null) {
      textFont(font);
    }
    textAlign(textAllignmentX, textAllignmentY);

    text(text, frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
  }
}
