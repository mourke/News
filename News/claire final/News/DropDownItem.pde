/*
class DropDownItem extends Widget {
  DropDownMenu parent;
  ArrayList<DropDownItem> dropDownGroup;
  
  public DropDownItem(DropDownMenu parent, ArrayList<DropDownItem> dropDownGroup, int event, String label) {
    super(parent.xpos(), parent.ypos() + (parent.height()*(dropDownGroup.size()+1)), event, label); 
    this.parent = parent;
    this.dropDownGroup = dropDownGroup;
  }
  
  @Override
  void draw() {
    if (mouseOver(mouseX, mouseY)) {
      fill(WIDGET_CLICKED);
    } else {
      fill(255);
    }
    rect(xpos(), ypos(), width(), height());
    fill(255, 0, 0);
    text(label(), xpos()+width()/5, ypos()+height()-height()/3);
  }
  
  boolean mouseOver(int mX, int mY) {
    return (mX >= xpos() && mX <= xpos()+width() && mY >= ypos() && mY <= ypos()+height());
  }
}
*/
