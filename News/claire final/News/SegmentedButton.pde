class SegmentedButton extends Checkbox {
  
  SegmentedButton(Rect frame, String text, ButtonDelegate delegate) {
    super(frame, text, delegate);
    textPadding = 20;
    
    textColorForControlState.put(ControlState.NORMAL, tintColor());
    textColorForControlState.put(ControlState.HIGHLIGHTED, tintColor());
    textColorForControlState.put(ControlState.SELECTED, color(0));
    textColorForControlState.put(ControlState.CUSTOM, color(255));

    backgroundColorForControlState.put(ControlState.NORMAL, color(1, 0, 0, 0));
    backgroundColorForControlState.put(ControlState.HIGHLIGHTED, color(1, 0, 0, 0));
    backgroundColorForControlState.put(ControlState.DISABLED, color(1, 0, 0, 0));
    backgroundColorForControlState.put(ControlState.SELECTED, color(240, 240, 240));
    backgroundColorForControlState.put(ControlState.CUSTOM, tintColor());
  }
}
