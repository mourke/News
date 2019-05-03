interface ButtonDelegate {
  void buttonClicked(Button button);
}

class Button extends Widget {

  protected Label textLabel;
  protected PImage image;
  protected ControlState controlState;
  protected HashMap<ControlState, Integer> textColorForControlState;
  protected HashMap<ControlState, Integer> backgroundColorForControlState;
  protected int textPadding = 50;
  protected ButtonDelegate delegate;

  public Button(Rect frame, String text, ButtonDelegate delegate) {
    super(frame);
    this.textLabel = new Label(text, frame);
    this.image = null;
    this.delegate = delegate;
    sharedInit();
    this.addChildWidget(textLabel);
    updateSize();
  }

  public Button(Rect frame, PImage image, ButtonDelegate delegate) {
    super(frame);
    this.textLabel = null;
    this.image = image;
    this.delegate = delegate;
    sharedInit();
  }

  protected void sharedInit() {
    controlState = ControlState.NORMAL;
    textColorForControlState = new HashMap<ControlState, Integer>();
    backgroundColorForControlState = new HashMap<ControlState, Integer>();

    textColorForControlState.put(ControlState.NORMAL, color(0));
    textColorForControlState.put(ControlState.HIGHLIGHTED, color(0));
    textColorForControlState.put(ControlState.DISABLED, color(180));
    textColorForControlState.put(ControlState.SELECTED, color(255));

    backgroundColorForControlState.put(ControlState.NORMAL, color(255));
    backgroundColorForControlState.put(ControlState.HIGHLIGHTED, color(255));
    backgroundColorForControlState.put(ControlState.DISABLED, color(50));
    backgroundColorForControlState.put(ControlState.SELECTED, tintColor());

    this.setCornerRadius(5);
  }

  public void setDelegate(ButtonDelegate delegate) {
    this.delegate = delegate;
  }

  public void setTitle(String title) {
    if (textLabel == null) return;
    this.textLabel.setText(title);
    updateSize();
  }

  public String title() {
    if (textLabel == null) return null;
    return this.textLabel.getText();
  }

  public void setFont(PFont font) {
    this.textLabel.setFont(font);
    updateSize();
  }

  public PFont font() {
    if (textLabel == null) return null;
    return this.textLabel.font();
  }

  protected void updateSize() {
    this.frame.width = textLabel.frame.width + textPadding;
  }
  
  @Override public void draw() {
    if (textLabel != null) {
      textLabel.textColor = textColorForControlState.get(controlState);
    }

    setBackgroundColor(backgroundColorForControlState.get(controlState));

    super.draw();

    if (image != null) {
      image(image, frame.x, frame.y, frame.height, frame.height);
    }
  }


  @Override public void mouseEnter() {
    controlState = ControlState.HIGHLIGHTED;
  }


  @Override public void mouseMove() {
    if (mousePressed) {
      controlState = isMouseInside ? ControlState.SELECTED : ControlState.NORMAL;
    } else {
      controlState = ControlState.HIGHLIGHTED;
    }
  }

  // called when the mouse had been inside the widget but is not anymore
  @Override public void mouseExit() {
    controlState = ControlState.NORMAL;
  }

  // called when the mouse is pressed and released inside the widget
  @Override public void mouseClickInside() {
    controlState = ControlState.NORMAL;

    if (delegate != null) {
      delegate.buttonClicked(this);
    }
  }

  // called when the mouse is pressed inside the widget but not released
  @Override public void mousePressInside() {
    controlState = ControlState.SELECTED;
  }
}
