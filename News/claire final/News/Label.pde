class Label extends Widget {

  private String text;
  private PFont font;
  private color textColor;
  private float maxWidth = Float.MAX_VALUE;

  public Label(String text, Rect frame) {
    super(frame);
    this.text = text;
    setBackgroundColor(color(255, 255, 255, 0));
    updateSize();
  }
  
  public void setMaxWidth(float maxWidth) {
    this.maxWidth = maxWidth;
  }

  public void setText(String text) {
    this.text = text;
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
    if (font != null) textFont(font); // textFont must be called so an accurate size can be calculated.
    float textWidth = textWidth(text);
    frame.width = textWidth > maxWidth ? maxWidth : textWidth;
  }

  public String getText() {
    return this.text;
  }

  public PFont font() {
    return this.font;
  }

  public void draw() {
    super.draw();

    fill(textColor);
    if (font != null) {
      textFont(font);
    }
    textAlign(CENTER, CENTER);

    text(text, frame.x + frame.width/2, frame.y + frame.height/2);
  }
}
