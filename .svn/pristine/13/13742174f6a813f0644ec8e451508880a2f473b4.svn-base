class Textbox {

  private int x, y, width, height;
  private boolean clicked;
  private String text;
  private int parameter;  //what does the textbox submit
  private String placeholderText;

  public Textbox(int x, int y, int width, int height, int parameter) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.parameter = parameter;

    clicked = false;
    text = "";
    placeholderText = "Search ";
  }

  public Textbox(int x, int y, int parameter) {
    this(x, y, TEXT_BOX_WIDTH, TEXT_BOX_HEIGHT, parameter);
  }

  public void click() {
    clicked = true;
  }

  public void deselect() {
    clicked = false;
  }

  public void draw() {
    stroke(0);
    if (clicked) {
      fill(WIDGET_CLICKED);
    } else {
      fill(TEXT_BOX_BACKGROUND);
    }
    rect(x, y, width, height, 5);

    textSize(TEXT_BOX_FONT_SIZE);
    textFont(textboxFont);
    if (text.equals("")) {
      fill(color(203, 203, 203));
      textAlign(LEFT);
      text(placeholderText, x + TEXT_BOX_FONT_SIZE, y + TEXT_BOX_FONT_SIZE*1.3f);
      //text(placeholderText, x + TEXT_BOX_FONT_SIZE, y + TEXT_BOX_FONT_SIZE*1.5f);
      image(search, x + width - (2*search.width), y+TEXT_BOX_FONT_SIZE/2);
    } else {
      fill(TEXT_BOX_TEXT);
      textAlign(LEFT);
      text(text, x + width/20, y + TEXT_BOX_FONT_SIZE*1.3f);
    }
  }

  public boolean withinBounds(int mX, int mY) {
    return (mX >= x && mX <= x+width && mY >= y && mY <= y+height);
  }

  public boolean isSelected() {
    return clicked;
  }

  public void appendCharacter(char c) {
    if (!full(c)) {
      text = text + c;
    }
  }

  public boolean full(char c) {
    return (textWidth(text+c) > width - width/20); // would adding another char overflow textbox?
  }

  public void removeChar() {
    if (text.length()!=0) {
      text = text.substring(0, text.length()-1);
    }
  }

  public void submitQuery() {
    if (text.length() > 0) {
      //if (parameter == TEXTBOX_USERNAME) {
      //  setUsername(text);
      //} else if (parameter == TEXTBOX_KEYWORD) {
      //  setKeyword(text);
      //} else if (parameter == TEXTBOX_USERPAGE) {
      //  setUserpageSubject(text);
      //}
      setUserpageSubject(text);
      text = "";
      print(text);
    }
  }

  public void setPlaceholderText(String text) {
    placeholderText = text;
  }
}
