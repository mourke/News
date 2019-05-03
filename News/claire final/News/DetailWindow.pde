import java.text.SimpleDateFormat;

class DetailWindow extends Window implements ButtonDelegate {

  private Label storyTitleLabel;
  private Label storyAuthorLabel;
  private FlatButton storyURLButton;
  private Label storyDateLabel;
  private RatingWidget scoreWidget;

  private Story story;
  private Comment[] comments;

  DetailWindow() {
    super();

    frame.x = 375;
    frame.width = width - frame.x;
    frame.y = 120;
    frame.height = height - frame.y;

    storyTitleLabel = new Label("Title", new Rect(frame.x + 70, frame.y, 0, 40));
    storyTitleLabel.setFont(subtitleFont);

    storyAuthorLabel = new Label("Author", new Rect(storyTitleLabel.frame.x, storyTitleLabel.frame.y + storyTitleLabel.frame.height + 16, 0, 16));
    storyAuthorLabel.setFont(captionFont);
    storyAuthorLabel.setTextColor(color(0, 0, 0, 102));

    storyURLButton = new FlatButton(new Rect(storyAuthorLabel.frame.x + storyAuthorLabel.frame.width + 7, storyAuthorLabel.frame.y, 0, 16), "URL", this);
    storyURLButton.setFont(captionFont);
   
    storyDateLabel = new Label("Date", new Rect(storyAuthorLabel.frame.x, storyURLButton.frame.y + storyURLButton.frame.height + 7, 0, 16));
    storyDateLabel.setFont(captionFont);
    storyDateLabel.setTextColor(color(0, 0, 0, 102));

    scoreWidget = new RatingWidget(new Rect(width - 120, storyAuthorLabel.frame.y, 0, 16), 3);

    addChildWidgets(new Widget[] {storyTitleLabel, storyAuthorLabel, storyURLButton, storyDateLabel, scoreWidget});
  }

  void setStory(Story story) {
    this.story = story;
    this.storyTitleLabel.setText(story.title());
    String author = story.author().substring(0, 1).toUpperCase() + story.author().substring(1).toLowerCase();

    if (story.url.isPresent()) {
      this.storyURLButton.setHidden(false);
      this.storyAuthorLabel.setText("By " + author + ", ");
      this.storyURLButton.frame.x = storyAuthorLabel.frame.x + storyAuthorLabel.frame.width; // update frame after author label size changes
      this.storyURLButton.setTitle(story.url.get().toString());
    } else {
      this.storyURLButton.setTitle("");
      this.storyURLButton.setHidden(true);
      this.storyAuthorLabel.setText("By " + author);
    }

    SimpleDateFormat formatter = new SimpleDateFormat("EEEE, dd MMMM yyyy HH:mm");
    storyDateLabel.setText(formatter.format(story.releaseDate()));
    scoreWidget.setRating((story.score()/56)); // rating is out of 280 on the api
  }

  void buttonClicked(Button button) {
    link(story.url.get().toString()); // no check for null here as button can only be pressed if the url is present
  }
}
