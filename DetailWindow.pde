import java.text.SimpleDateFormat;

class DetailWindow extends Window implements ButtonDelegate, TableWidgetDelegate {

  private Label storyTitleLabel;
  private Label storyAuthorLabel;
  private FlatButton storyURLButton;
  private Label storyDateLabel;
  private RatingWidget scoreWidget;
  private TableWidget commentsTableWidget;
  private Label noCommentsLabel;
  Widget backgroundWidget;

  private Story story;
  private ArrayList<Comment> comments = new ArrayList<Comment>();

  DetailWindow() {
    super();

    frame.origin.x = 375;
    frame.size.width = width - frame.origin.x;
    frame.origin.y = 100;
    frame.size.height = height - frame.origin.y;

    noCommentsLabel = new Label("No comments on this story yet", new Point(frame.origin.x + frame.size.width/2 - 80, frame.origin.y + frame.size.height/2 - 20));
    noCommentsLabel.setFont(captionFont);
    noCommentsLabel.setTextColor(color(0, 0, 0, 102));

    storyTitleLabel = new Label("Title", new Point(frame.origin.x + 70, frame.origin.y));
    storyTitleLabel.setFont(subtitleFont);
    storyTitleLabel.setMaxWidth(width - storyTitleLabel.frame.origin.x - 40);
    storyTitleLabel.setMaxLines(4);

    storyAuthorLabel = new Label("Author", new Point(storyTitleLabel.frame.origin.x, storyTitleLabel.frame.origin.y + storyTitleLabel.frame.size.height + 16));
    storyAuthorLabel.setFont(captionFont);
    storyAuthorLabel.setTextColor(color(0, 0, 0, 102));

    storyURLButton = new FlatButton(new Rect(storyAuthorLabel.frame.origin.x + storyAuthorLabel.frame.size.width + 7, storyAuthorLabel.frame.origin.y, 0, 16), "URL", this);
    storyURLButton.setFont(captionFont);

    storyDateLabel = new Label("Date", new Point(storyAuthorLabel.frame.origin.x, storyURLButton.frame.origin.y + storyURLButton.frame.size.height + 7));
    storyDateLabel.setFont(captionFont);
    storyDateLabel.setTextColor(color(0, 0, 0, 102));

    scoreWidget = new RatingWidget(new Rect(width - 120, storyAuthorLabel.frame.origin.y, 0, 16), 3);

    float tableWidgetY = storyDateLabel.frame.origin.y + storyDateLabel.frame.size.height + 32;
    commentsTableWidget = new TableWidget(new Rect(frame.origin.x, tableWidgetY, width - frame.origin.x, height - tableWidgetY), this);
    commentsTableWidget.setInterCellSpacing(20);

    backgroundWidget = new Widget(new Rect(commentsTableWidget.frame.origin.x, 0, commentsTableWidget.frame.size.width, commentsTableWidget.frame.origin.y)); // this widget is to stop overscrolling on the table view.

    addChildWidgets(new Widget[] {commentsTableWidget, backgroundWidget, storyTitleLabel, storyAuthorLabel, storyURLButton, storyDateLabel, scoreWidget, noCommentsLabel});
  }

  void setStory(Story story) {
    this.story = story;
    this.storyTitleLabel.setText(story.title());
    String author = story.author().substring(0, 1).toUpperCase() + story.author().substring(1).toLowerCase();

    if (story.url.isPresent()) {
      this.storyURLButton.setHidden(false);
      this.storyAuthorLabel.setText("By " + author + ", ");
      this.storyURLButton.setTitle(story.url.get().toString());
    } else {
      this.storyURLButton.setTitle("");
      this.storyURLButton.setHidden(true);
      this.storyAuthorLabel.setText("By " + author);
    }

    this.storyURLButton.frame.origin.x = storyAuthorLabel.frame.origin.x + storyAuthorLabel.frame.size.width; // update frame after author label size changes
    this.storyURLButton.frame.origin.y = storyTitleLabel.frame.origin.y + storyTitleLabel.frame.size.height + 16;
    this.storyURLButton.setMaxWidth(scoreWidget.frame.origin.x - storyURLButton.frame.origin.x - 10);
    this.storyAuthorLabel.frame.origin.y = storyURLButton.frame.origin.y;

    SimpleDateFormat formatter = new SimpleDateFormat("EEEE, dd MMMM yyyy HH:mm");
    storyDateLabel.setText(formatter.format(story.releaseDate()));
    storyDateLabel.frame.origin.y = storyURLButton.frame.origin.y + storyURLButton.frame.size.height + 7;

    try {
      scoreWidget.setRating((story.score()/4)); // rating is out of 20 on the api
      scoreWidget.frame.origin.y = storyURLButton.frame.origin.y;
      scoreWidget.setHidden(false);
    } 
    catch (IllegalArgumentException e) {
      scoreWidget.setHidden(true);
    }

    float tableWidgetY = storyDateLabel.frame.origin.y + storyDateLabel.frame.size.height + 32;
    commentsTableWidget.frame.origin.y = tableWidgetY;
    commentsTableWidget.frame.size.height = height - tableWidgetY;
    backgroundWidget.frame.size.height = commentsTableWidget.frame.origin.y;
  }

  void setComments(ArrayList<Comment> comments) {
    this.comments = comments;
    this.commentsTableWidget.reloadData();
  }

  // Button delegate

  void buttonClicked(Button button) {
    link(story.url.get().toString()); // no check for null here as button can only be pressed if the url is present
  }

  // Table widget delegate

  Integer numberOfCellsInTableWidget(TableWidget tableWidget) {
    Integer size = comments.size();
    noCommentsLabel.setHidden(size != 0);
    return comments.size();
  }

  TableWidgetCell cellForRowWithFrame(Rect frame, TableWidget tableWidget, Integer row) {
    frame.size.width = 350;
    frame.origin.x = storyTitleLabel.frame.origin.x;
    CommentTableWidgetCell cell = new CommentTableWidgetCell(frame, tableWidget);
    Comment comment = comments.get(row);
    SimpleDateFormat formatter = new SimpleDateFormat("dd MMMM HH:mm");
    cell.subtitleLabel.setText(formatter.format(story.releaseDate()));
    cell.titleLabel.setText(comment.author());
    cell.titleLabel.setText(comment.author());
    cell.commentLabel.setText(comment.text());
    cell.frame.size.height = cell.commentLabel.frame.origin.y + cell.commentLabel.frame.size.height - cell.frame.origin.y + 10;
    return cell;
  }

  void cellSelected(Integer row) {
  }
}
