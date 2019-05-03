class RatingWidget extends Widget {
  
  private PImage emptyStarImage;
  private PImage fullStarImage;
  private static final int SPACING = 5;
  private static final int TOTAL_STARS = 5;
  private int rating;
  
  // rating goes from 0 to 5.
  RatingWidget(Rect frame, int rating) throws IndexOutOfBoundsException {
    super(new Rect(frame.x, frame.y, (frame.height * 5) + (SPACING * 4), frame.height));
    
    setRating(rating);
    emptyStarImage = loadImage("starEmpty.png");
    fullStarImage = loadImage("starFull.png");
    
    this.backgroundColor = color(1, 0, 0, 0);
  }
  
  // rating goes from 0 to 5.
  void setRating(int rating) throws IndexOutOfBoundsException {
    if (rating < 0 || rating > 5) throw new IndexOutOfBoundsException("Rating must be between 0 and 5");
    this.rating = rating;
  }
  
  int rating() {
    return rating;
  }
  
  @Override void draw() {
    super.draw();
    
    for (int i = 0; i < rating; ++i) {
      image(fullStarImage, frame.x + (i * frame.height) + (i * SPACING), frame.y, frame.height, frame.height);
    }
    
    for (int i = rating; i < TOTAL_STARS; ++i) {
      image(emptyStarImage, frame.x + (i * frame.height) + (i * SPACING), frame.y, frame.height, frame.height);
    }
  }
}
