class Rect {

  public Point origin;
  public Size size;

  Rect(float x, float y, float width, float height) {
    this.origin = new Point(x, y);
    this.size = new Size(width, height);
  }

  Rect(Point origin, Size size) {
    this.origin = origin;
    this.size = size;
  }

  boolean isInside(Rect otherRect) {
    boolean isInsideHeight = (this.origin.y >= otherRect.origin.y && this.origin.y <= otherRect.origin.y + otherRect.size.height) || (this.origin.y + this.size.height >= otherRect.origin.y && this.origin.y <= otherRect.origin.y + otherRect.size.height);
    boolean isInsideWidth = this.origin.x >= otherRect.origin.x && this.origin.x <= otherRect.origin.x + otherRect.size.width;

    return isInsideHeight && isInsideWidth;
  }

  @Override public String toString() {
    return super.toString() + " x: " + origin.x + "; y: " + origin.y + "; width: " + size.width + "; height: " + size.height;
  }
}

class Point {
  public float x, y;

  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

class Size {
  public float width, height;

  Size(float width, float height) {
    this.width = width;
    this.height = height;
  }
}
