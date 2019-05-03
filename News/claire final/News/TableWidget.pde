interface TableWidgetDelegate {
  Integer numberOfCellsInTableWidget(TableWidget tableWidget);
  void willDisplayCellInTableWidget(TableWidgetCell cell, TableWidget tableWidget, Integer row);
  void cellSelected(Integer row);
}

class TableWidget extends ScrollWidget implements TableWidgetCellDelegate {

  private ArrayList<TableWidgetCell> cells = new ArrayList<TableWidgetCell>();
  private TableWidgetDelegate delegate;
  private int numberOfRows;
  private int selectedCellIndex = 0;

  TableWidget(Rect frame, TableWidgetDelegate delegate) throws NullPointerException {
    super(frame);

    if (delegate == null) throw new NullPointerException("TableWidget must have a non-null delegate");
    this.delegate = delegate;

    reloadData();
  }

  void reloadData() {
    numberOfRows = delegate.numberOfCellsInTableWidget(this);

    children().removeAll(children());
    
    selectedCellIndex = 0;
    Rect previousCellFrame = null;
    for (int i = 0; i < numberOfRows; ++i) {
      float cellFrameY = i != 0 ? previousCellFrame.y + previousCellFrame.height : frame.y;
      TableWidgetCell cell = new TableWidgetCell(new Rect(frame.x, cellFrameY, frame.width, 96), this);
      delegate.willDisplayCellInTableWidget(cell, this, i);
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
