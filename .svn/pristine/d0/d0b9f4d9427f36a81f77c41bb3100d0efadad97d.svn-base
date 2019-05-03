interface TableWidgetCellDelegate {
  void cellSelected(TableWidgetCell cell);
}

class TableWidgetCell extends Widget {

  protected Label titleLabel;
  protected Label subtitleLabel;
  protected color selectedBackgroundColor;
  protected boolean selected = false;
  protected TableWidgetCellDelegate delegate;

  TableWidgetCell(Rect frame, TableWidgetCellDelegate delegate) {
    super(frame);

    titleLabel = new Label("Title", new Rect(frame.x + 28, frame.y + 25, 0, 20));
    titleLabel.setFont(textFont);

    subtitleLabel = new Label("Subtitle", new Rect(frame.x + 28, titleLabel.frame.y + titleLabel.frame.height + 6, 0, 16));
    subtitleLabel.setFont(captionFont);
    subtitleLabel.setTextColor(color(0, 0, 0, 128));

    addChildWidgets(new Widget[] {titleLabel, subtitleLabel});

    selectedBackgroundColor = color(242, 242, 242);
    backgroundColor = color(1, 0, 0, 0);

    this.delegate = delegate;
  }

  void setSelectedBackgroundColor(color selectedBackgroundColor) {
    this.selectedBackgroundColor = selectedBackgroundColor;
  }

  color selectedBackgroundColor() {
    return this.selectedBackgroundColor;
  }

  boolean isSelected() {
    return selected;
  }

  void setSelected(boolean selected) {
    this.selected = selected;

    if (selected && delegate != null) delegate.cellSelected(this);
  }

  @Override void draw() {
    // copy background color, and change background color for drawing if selected, and then restore background color
    color _backgroundColor = backgroundColor;
    backgroundColor = selected ? selectedBackgroundColor : backgroundColor;
    super.draw();
    backgroundColor = _backgroundColor;
  }

  // called when the mouse is pressed and released inside the widget
  public void mouseClickInside() {
    setSelected(true);
  }
}
