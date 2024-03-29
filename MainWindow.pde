class MainWindow extends Window implements SegmentedWidgetDelegate, TableWidgetDelegate, SearchBarDelegate {

  private Label titleLabel;
  private SegmentedWidget segmentedControl;
  private DetailWindow detailWindow;
  private TableWidget tableWidget;
  private SearchBar searchBar;
  private ArrayList<Story> dataSource = new ArrayList<Story>();
  ArrayList<Story> stories;
  ArrayList<Comment> comments;

  MainWindow(ArrayList<Story> stories, ArrayList<Comment> comments) {
    super();

    this.stories = stories;
    this.comments = comments;

    titleLabel = new Label("Stories", new Point(frame.origin.x + 20, frame.origin.y + 20));
    titleLabel.setFont(titleFont);

    segmentedControl = new SegmentedWidget(new Rect(frame.origin.x + 20, titleLabel.frame.origin.y + titleLabel.frame.size.height + 20, 0, 20), this);
    segmentedControl.addSegment("Date");
    segmentedControl.addSegment("Rating");
    segmentedControl.addSegment("Comments");

    detailWindow = new DetailWindow();

    float tableWidgetY = segmentedControl.frame.origin.y + segmentedControl.frame.size.height + 20;
    tableWidget = new TableWidget(new Rect(frame.origin.x, tableWidgetY, detailWindow.frame.origin.x, height - tableWidgetY), this);

    float searchBarWidth = 260;
    searchBar = new SearchBar(new Rect(frame.size.width - searchBarWidth - 20, frame.origin.y + 20, searchBarWidth, 22), this);

    Widget backgroundWidget = new Widget(new Rect(0, 0, tableWidget.frame.size.width, tableWidget.frame.origin.y)); // this widget is to stop overscrolling on the table view.

    backgroundColor = color(253, 253, 253);
    detailWindow.backgroundColor = backgroundColor;
    backgroundWidget.backgroundColor = backgroundColor;
    detailWindow.backgroundWidget.backgroundColor = backgroundColor;

    addChildWidgets(new Widget[] {tableWidget, backgroundWidget, titleLabel, segmentedControl, detailWindow, searchBar});

    setDataSource(mostRecentStories(stories));
  }

  void setDataSource(ArrayList<Story> dataSource) {
    this.dataSource = dataSource;
    this.tableWidget.reloadData();
  }

  ArrayList<Story> mostCommentedStories(ArrayList<Story> stories) {
    ArrayList<Story> mostCommentedStories = new ArrayList<Story>();

    for (Story story : stories) {
      if (story.numberOfComments() >= 10) {
        mostCommentedStories.add(story);
      }
    }
    Collections.sort(mostCommentedStories, new CommentNumberComparator());
    return mostCommentedStories;
  } 

  ArrayList<Story> highRatedStories(ArrayList<Story> stories) {
    ArrayList<Story> highRatedStories = new ArrayList<Story>(stories);
    Collections.sort(highRatedStories, new HighestRatedComparator());
    return highRatedStories;
  }

  ArrayList<Story> mostRecentStories(ArrayList<Story> stories) {
    ArrayList<Story> mostRecentStories = new ArrayList<Story>(stories);
    Collections.sort(mostRecentStories, new MostRecentComparator());
    return mostRecentStories;
  }


  // Segmented Widget Delegate

  void selectedSegmentIndexChanged(int index) {
    searchBarTextChanged(searchBar, searchBar.text());
  }

  // Table Widget Delegate

  Integer numberOfCellsInTableWidget(TableWidget tableWidget) {
    return dataSource.size();
  }

  TableWidgetCell cellForRowWithFrame(Rect frame, TableWidget tableWidget, Integer row) {
    TableWidgetCell cell = new TableWidgetCell(frame, tableWidget);
    Story story = dataSource.get(row);
    cell.titleLabel.setText(story.title());
    cell.subtitleLabel.setText((String)(story.url().isPresent() ? story.url().get().getHost() : ""));
    return cell;
  }

  void cellSelected(Integer row) {
    Story story = dataSource.get(row);
    detailWindow.setStory(story);
    detailWindow.setComments(story.matchingComments(comments));
  }

  // Search Bar Delegate

  void searchBarTextChanged(SearchBar searchBar, String query) {
    ArrayList<Story> searchQuery = new ArrayList<Story>();

    for (Story story : stories) {
      if (!story.title().contains(query)) continue;
      searchQuery.add(story);
    }

    switch (segmentedControl.selectedSegmentIndex) {
    case 0:
      setDataSource(mostRecentStories(searchQuery));
      break;
    case 1:
      setDataSource(highRatedStories(searchQuery));
      break;
    case 2:
      setDataSource(mostCommentedStories(searchQuery));
      break;
    default:
      break;
    }
  }
}
