class MainWindow extends Window implements SegmentedWidgetDelegate, TableWidgetDelegate {

  private Label titleLabel;
  private SegmentedWidget segmentedControl;
  private DetailWindow detailWindow;
  private TableWidget tableWidget;
  private SearchBar searchBar; 
  private ArrayList<Story> stories = new ArrayList<Story>();
  int indexState;

  MainWindow() {
    super();
    titleLabel = new Label("Stories", new Rect(20, 20, 0, 44));
    titleLabel.setFont(titleFont);

    segmentedControl = new SegmentedWidget(new Rect(20, titleLabel.frame.y + titleLabel.frame.height + 20, 0, 20), this);
    segmentedControl.addSegment("Date");
    segmentedControl.addSegment("Rating");
    segmentedControl.addSegment("Name");
    segmentedControl.addSegment("Graph");
    segmentedControl.addSegment("Profile");

    detailWindow = new DetailWindow();

    float tableWidgetY = segmentedControl.frame.y + segmentedControl.frame.height + 20;
    tableWidget = new TableWidget(new Rect(0, tableWidgetY, detailWindow.frame.x, height - tableWidgetY), this);



    addChildWidgets(new Widget[] {titleLabel, segmentedControl, detailWindow, tableWidget});
    backgroundColor = color(253, 253, 253);
    detailWindow.backgroundColor = backgroundColor;
  }

  void setDataSource(ArrayList<Story> stories) {
    this.stories = stories;
    this.tableWidget.reloadData();
  }
  int getIndexState() {
    return indexState;
  }


  // Segmented Widget Delegate

  void selectedSegmentIndexChanged(int index) {
    this.indexState = index;

    switch(index) {
    case 0:
      tableWidget.setHidden(false);
      detailWindow.setHidden(false);
      segmentedControl.setHidden(false);


      break;
    case 1:
      tableWidget.setHidden(false);
      detailWindow.setHidden(false);
      segmentedControl.setHidden(false);


      break;
    case 2:
      tableWidget.setHidden(false);
      detailWindow.setHidden(false);
      segmentedControl.setHidden(false);


      break;
    case 3:
      tableWidget.setHidden(true);
      detailWindow.setHidden(true);
      segmentedControl.setHidden(false);


      break;
    case 4:
      tableWidget.setHidden(true);
      detailWindow.setHidden(true);
      segmentedControl.setHidden(true);
    }
    println("Selected segment changed");
  }

  // Table Widget Delegate

  Integer numberOfCellsInTableWidget(TableWidget tableWidget) {
    return stories.size();
  }

  void willDisplayCellInTableWidget(TableWidgetCell cell, TableWidget tableWidget, Integer row) {
    Story story = stories.get(row);
    cell.titleLabel.setText(story.title());
    cell.subtitleLabel.setText((String)(story.url().isPresent() ? story.url().get().getHost() : ""));
  }

  void cellSelected(Integer row) {
    Story story = stories.get(row);
    detailWindow.setStory(story);
  }
}
