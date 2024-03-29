class Widget {

  public Rect frame;
  protected ArrayList<Widget> childWidgets = new ArrayList<Widget>();
  protected color backgroundColor = color(255);
  protected color tintColor = color(74, 139, 246);
  protected color borderColor = color(0, 0, 0);
  protected float borderWidth = 0;
  protected float cornerRadius = 0;
  protected boolean isMouseInside = false;
  protected boolean hidden = false;
  protected boolean clipsToBounds = true;

  public Widget(Rect frame) {
    this.frame = frame;
  }

  public void setHidden(boolean hidden) {
    this.hidden = hidden;
  }

  public boolean isHidden() {
    return hidden;
  }

  public void setBackgroundColor(color backgroundColor) {
    this.backgroundColor = backgroundColor;
  }

  public void setBorderColor(color borderColor) {
    this.borderColor = borderColor;
  }

  public void setCornerRadius(float cornerRadius) {
    this.cornerRadius = cornerRadius;
  }

  public void setBorderWidth(float borderWidth) {
    this.borderWidth = borderWidth;
  }

  public void setTintColor(color tintColor) {
    this.tintColor = tintColor;

    for (Widget child : childWidgets) {
      child.tintColor = tintColor;
    }
  }

  public void setClipsToBounds(boolean clipsToBounds) {
    this.clipsToBounds = clipsToBounds;
  }

  public color tintColor() {
    return this.tintColor;
  }

  public ArrayList<Widget> children() {
    return childWidgets;
  }

  public ArrayList<Widget> allChildren() {
    ArrayList<Widget> allChildren = new ArrayList<Widget>();
    for (Widget child : children()) {
      allChildren.add(child);
      allChildren.addAll(child.allChildren());
    }
    return allChildren;
  }

  public void addChildWidget(Widget child) {
    childWidgets.add(child);
    child.tintColor = tintColor;
  }

  public void addChildWidgets(Widget[] children) {
    for (Widget child : children) {
      addChildWidget(child);
    }
  }

  public void draw() {
    if (hidden) return;

    if (borderWidth == 0) {
      noStroke();
    } else {
      strokeWeight(borderWidth);
      stroke(borderColor);
    }

    fill(backgroundColor);
    if (cornerRadius == frame.size.width/2 && cornerRadius == frame.size.height/2) { // widget is a perfect elipse
      ellipseMode(CORNER); 
      ellipse(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    } else {
      rect(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height, cornerRadius);
    }

    for (Widget child : childWidgets) {
      if (clipsToBounds && !child.frame.isInside(frame)) continue; // don't draw child if it is not contained within parent
      child.draw();
    }
  }

  // called when the mouse has first entered the widget
  public void mouseEnter() {
  }

  // called when the mouse has already entered the widget and is now moving around inside it
  public void mouseMove() {
  }

  // called when the mouse had been inside the widget but is not anymore
  public void mouseExit() {
  }

  // called when the mouse is pressed and released inside the widget
  public void mouseClickInside() {
  }

  // called when the mouse is pressed inside the widget but not released
  public void mousePressInside() {
  }

  // called when the scroll wheel on the mouse is moved. A positive value indicates scroll down and a negative value indicates scroll up.
  public void mouseScroll(int value) {
  }


  public void mousePressed() {
    if (hidden) return;
    
    Rect mouseRect = new Rect(mouseX, mouseY, 0, 0);
    if (mouseRect.isInside(frame)) {
      this.mousePressInside();
    }

    for (Widget widget : children()) {
      widget.mousePressed();
    }
  }

  public void mouseMoved() {
    if (hidden) return;
    Rect mouseRect = new Rect(mouseX, mouseY, 0, 0);
    if (mouseRect.isInside(frame)) {
      if (isMouseInside) {
        this.mouseMove();
      } else {
        this.mouseEnter();
        isMouseInside = true;
      }
    } else if (isMouseInside) {
      isMouseInside = false;
      this.mouseExit();
    }

    for (Widget widget : children()) {
      widget.mouseMoved();
    }
  }

  public void mouseReleased() {
    if (hidden) return;
    Rect mouseRect = new Rect(mouseX, mouseY, 0, 0);
    if (mouseRect.isInside(frame)) {
      this.mouseClickInside();
    }

    for (Widget widget : children()) {
      widget.mouseReleased();
    }
  }

  public void mouseDragged() {
    if (hidden) return;
    mouseMoved();

    for (Widget widget : children()) {
      widget.mouseDragged();
    }
  }

  public void mouseWheel(MouseEvent event) {
    if (hidden) return;
    Rect mouseRect = new Rect(mouseX, mouseY, 0, 0);
    if (!mouseRect.isInside(frame)) return; // only scroll the view if the mouse is inside said view
    
    int value = event.getCount();
    value *= 4; // increase value to make scrolling more natural
    String OS = platformNames[platform];

    if (OS.equals("macosx")) {
      value = -value; // assume natural scrolling is turned on by default
    } 

    this.mouseScroll(value);

    for (Widget widget : children()) {
      widget.mouseWheel(event);
    }
  }

  public void keyPressed() {
    if (hidden) return;
    for (Widget widget : children()) {
      widget.keyPressed();
    }
  }
}
