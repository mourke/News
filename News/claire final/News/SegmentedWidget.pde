interface SegmentedWidgetDelegate {
  void selectedSegmentIndexChanged(int index);
}

class SegmentedWidget extends Widget implements ButtonDelegate {

  private ArrayList<SegmentedButton> segments;
  private int selectedSegmentIndex = 0;
  protected SegmentedWidgetDelegate delegate;
  protected final int SPACING = 15;
  protected PFont font;

  SegmentedWidget(Rect frame, SegmentedWidgetDelegate delegate) {
    super(frame);

    this.backgroundColor = color(1, 0, 0, 0);
    segments = new ArrayList<SegmentedButton>();
    this.delegate = delegate;
    this.font = textFont;
  }

  void setSelectedSegmentIndex(int selectedSegmentIndex) throws ArrayIndexOutOfBoundsException {
    if (!isSegmentIndexValid(selectedSegmentIndex) || this.selectedSegmentIndex == selectedSegmentIndex) return;
    segments.get(this.selectedSegmentIndex).setChecked(false);
    this.selectedSegmentIndex = selectedSegmentIndex;
    segments.get(this.selectedSegmentIndex).setChecked(true);

    if (delegate != null) delegate.selectedSegmentIndexChanged(selectedSegmentIndex);
  }

  void addSegment(String text) {
    SegmentedButton segment;

    if (segments.size() != 0) {
      Rect previousFrame = segments.get(segments.size() - 1).frame;
      segment = new SegmentedButton(new Rect(previousFrame.x + previousFrame.width + SPACING, frame.y, 0, frame.height), text, this);
    } else {
      segment = new SegmentedButton(new Rect(frame.x, frame.y, 0, frame.height), text, this);
      segment.setChecked(true);
    }
    
    frame.width += SPACING + segment.frame.width; 
    segment.setFont(font);
    addChildWidget(segment);
    segments.add(segment);
  }

  boolean isSegmentIndexValid(int index) throws ArrayIndexOutOfBoundsException {
    if (index >= 0 && index < segments.size()) {
      return true;
    } else {
      throw new ArrayIndexOutOfBoundsException("The segment index passed was out of range.");
    }
  }

  void buttonClicked(Button button) {
    int selectedSegmentIndex = segments.indexOf(button);
    ((SegmentedButton)button).setChecked(true); // button should not be unchecked by pressing on it when already checked which is default behaviour
    setSelectedSegmentIndex(selectedSegmentIndex);
  }
  
  void setFont(PFont font) {
    this.font = font;
  }
  
  PFont font() {
    return this.font;
  }
}
