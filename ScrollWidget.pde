class ScrollWidget extends Widget {

  protected int contentOffsetY = 0;
  protected float contentHeight = 0;

  ScrollWidget(Rect frame) {
    super(frame);
    this.backgroundColor = color(1, 0, 0, 0);
  }

  void scrollToTop() {
    mouseScroll(-contentOffsetY);
  }
  
  private float maxContentOffsetY() {
    return contentHeight - frame.size.height - frame.origin.y;
  }

  boolean isAtTop() {
    return contentOffsetY == 0;
  }

  boolean isAtBottom() {
    if (!canScroll()) return true;
    return (-contentOffsetY) >= maxContentOffsetY();
  }

  private boolean canScroll() {
    return contentHeight > frame.size.height;
  }

  @Override public void addChildWidget(Widget child) {
    super.addChildWidget(child);

    if ((child.frame.size.height + child.frame.origin.y - frame.origin.y) > contentHeight) {
      contentHeight = child.frame.size.height + child.frame.origin.y - frame.origin.y;
    }
  }

  // called when the scroll wheel on the mouse is moved. A positive value indicates scroll down and a negative value indicates scroll up.
  @Override public void mouseScroll(int value) {
    if (!canScroll()) return;
    if (isAtBottom() && value < 0) return; // user is trying to scroll down when already at the bottom
    if (isAtTop() && value > 0) return; // user is trying to scroll up when already at the top
    if (contentOffsetY + value > 0) value = -contentOffsetY; // reset scrolling
    if (contentOffsetY + value < -maxContentOffsetY()) value = -int(maxContentOffsetY() + contentOffsetY); 

    contentOffsetY += value;

    for (Widget child : allChildren()) {
      child.frame.origin.y += value;
    }
  }
}
