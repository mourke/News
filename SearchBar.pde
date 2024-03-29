interface SearchBarDelegate {
  void searchBarTextChanged(SearchBar searchBar, String query);
}

public class SearchBar extends Widget {

  private Label textLabel;
  protected Rect caretFrame;
  private boolean focused;
  private static final String PLACEHOLDER_TEXT = "Search";
  private Label placeholderTextLabel;
  private static final int PULSE_COUNTER_MAX = 75; // caret spends half this value hidden and half shown
  private static final int TEXT_INSET = 5;
  private int pulseCounter = PULSE_COUNTER_MAX;
  private SearchBarDelegate delegate;

  SearchBar(Rect frame, SearchBarDelegate delegate) {
    super(frame);

    this.delegate = delegate;
    textLabel = new Label("", new Point(frame.origin.x + TEXT_INSET, frame.origin.y + 4));
    placeholderTextLabel = new Label(PLACEHOLDER_TEXT, new Point(textLabel.frame.origin.x, textLabel.frame.origin.y));
    textLabel.setFont(captionFont);
    textLabel.setMaxWidth(frame.size.width - (TEXT_INSET * 2));
    placeholderTextLabel.setFont(captionFont);
    placeholderTextLabel.setTextColor(color(0, 0, 0, 102));
    caretFrame = new Rect(textLabel.frame.origin.x, frame.origin.y, 1, 22);
    
    addChildWidget(textLabel);
    addChildWidget(placeholderTextLabel);
    
    setBackgroundColor(color(142, 142, 147, 31));
    setCornerRadius(5);
  }
  
  String text() {
    return textLabel.getText();
  }

  boolean isFocused() {
    return focused;
  }

  @Override void draw() {
    super.draw();

    if (focused && pulseCounter >= PULSE_COUNTER_MAX/2) {
      fill(color(0));
      rect(caretFrame.origin.x, caretFrame.origin.y, caretFrame.size.width, caretFrame.size.height);
    }

    pulseCounter = (pulseCounter <= 0) ? PULSE_COUNTER_MAX : (pulseCounter - 1);
  }
  
  private void updateCaretPosition() {
    caretFrame.origin.x = textLabel.frame.origin.x + textLabel.frame.size.width;
  }

  private void appendCharacter(char c) {
    textLabel.setText(textLabel.getText() + c);
    updateCaretPosition();
    if (!placeholderTextLabel.isHidden()) placeholderTextLabel.setHidden(true);
  }

  private void removeLastCharacter() {
    String query = textLabel.getText();
    if (query.length() == 0) return;
    query = query.substring(0, query.length() - 1);
    if (query.length() == 0) placeholderTextLabel.setHidden(false); // only show when there is no text in the search bar
    textLabel.setText(query);
    updateCaretPosition();
  }

  // called when the mouse is pressed and released inside the widget
  @Override public void mouseClickInside() {
    focused = true;
  }


  @Override public void mousePressed() {
    focused = false; // set focus to false so that if the mouse is pressed outside the widget the searchbar will become unfocused.
    super.mousePressed();
  }

  @Override public void keyPressed() {
    if (!focused) return;

    if (key == BACKSPACE) {
      removeLastCharacter();
    } else if (key == ENTER) {
      if (delegate != null) delegate.searchBarTextChanged(this, textLabel.getText());
    } else {
      appendCharacter(key);
    }
  }
}
