public class Checkbox extends Button {

  protected PImage checkedImage;
  protected boolean checked = false;

  public Checkbox(Rect frame, ButtonDelegate delegate) {
    super(frame, loadImage("checkmark.png"), delegate);
    this.checkedImage = this.image;
    borderWidth = 1;
    borderColor = color(95, 95, 95, 100);

    backgroundColorForControlState.put(ControlState.SELECTED, color(240, 240, 240));
    backgroundColorForControlState.put(ControlState.CUSTOM, tintColor());
  }

  public Checkbox(Rect frame, String text, ButtonDelegate delegate) {
    super(frame, text, delegate);
  }

  public boolean isChecked() {
    return checked;
  }

  public void setChecked(boolean checked) {
    this.checked = checked;
    
    if (checked) {
      controlState = ControlState.CUSTOM;
      textColorForControlState.put(ControlState.SELECTED, color(255));
      backgroundColorForControlState.put(ControlState.SELECTED, color(10, 106, 251));
    } else {
      controlState = ControlState.NORMAL;
      textColorForControlState.put(ControlState.SELECTED, color(0));
      backgroundColorForControlState.put(ControlState.SELECTED, color(240, 240, 240));
    }
  }

  public void draw() {
    if (checked) {
      image = checkedImage;
      float borderWidth = this.borderWidth;
      this.borderWidth = 0; // remove stroke
      super.draw();
      this.borderWidth = borderWidth;
    } else {
      image = null; // stop the tick image from being drawn.
      super.draw();
    }
  }

  @Override public void mouseEnter() {
    controlState = checked ? ControlState.CUSTOM : ControlState.HIGHLIGHTED;
  }


  @Override public void mouseMove() {
    controlState = checked ? ControlState.CUSTOM : mousePressed ? ControlState.SELECTED : ControlState.HIGHLIGHTED;
  }

  // called when the mouse had been inside the widget but is not anymore
  @Override public void mouseExit() {
    controlState = checked ? ControlState.CUSTOM : ControlState.NORMAL;
  }

  @Override public void mouseClickInside() {
    setChecked(!checked);
    super.mouseClickInside();
  }
}
