interface TableWidgetDelegate {
  Integer numberOfCellsInTableWidget(TableWidget tableWidget);
  TableWidgetCell cellForRowWithFrame(Rect frame, TableWidget tableWidget, Integer row);
  void cellSelected(Integer row);
}

class TableWidget extends ScrollWidget implements TableWidgetCellDelegate {

  private ArrayList<TableWidgetCell> cells = new ArrayList<TableWidgetCell>();
  private TableWidgetDelegate delegate;
  private int numberOfRows;
  private int selectedCellIndex = 0;
  private float interCellSpacing = 0;

  TableWidget(Rect frame, TableWidgetDelegate delegate) throws NullPointerException {
    super(frame);

    if (delegate == null) throw new NullPointerException("TableWidget must have a non-null delegate");
    this.delegate = delegate;

    reloadData();
  }
  
  void setInterCellSpacing(float interCellSpacing) {
    this.interCellSpacing = interCellSpacing;
    reloadData();
  }

  void reloadData() {
    scrollToTop();
    contentHeight = 0; // reset content height as new widgets are being added.
    numberOfRows = delegate.numberOfCellsInTableWidget(this);

    children().removeAll(children());
    cells.removeAll(cells);
    
    selectedCellIndex = 0;
    Rect previousCellFrame = null;
    for (int i = 0; i < numberOfRows; ++i) {
      float cellFrameY = i != 0 ? previousCellFrame.origin.y + previousCellFrame.size.height + interCellSpacing : frame.origin.y;
      TableWidgetCell cell = delegate.cellForRowWithFrame(new Rect(frame.origin.x, cellFrameY, frame.size.width, 96), this, i);
      cell.delegate = this;
      addChildWidget(cell);
      cells.add(cell);
      if (i == selectedCellIndex) cell.setSelected(true);
      previousCellFrame = cell.frame;
    }
  }

  void cellSelected(TableWidgetCell cell) {
    int index = cells.indexOf(cell);
    try {
      if (selectedCellIndex != index) cells.get(selectedCellIndex).setSelected(false);
    } catch (IndexOutOfBoundsException e) {}
    selectedCellIndex = index;
    delegate.cellSelected(index);
  }
}
