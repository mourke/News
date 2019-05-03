class FlatButton extends Button {

  FlatButton(Rect frame, String text, ButtonDelegate delegate) {
    super(frame, text, delegate);
    textColorForControlState.put(ControlState.NORMAL, tintColor());
    textColorForControlState.put(ControlState.HIGHLIGHTED, tintColor());
    textColorForControlState.put(ControlState.SELECTED, color(1, 0, 0, 30));

    backgroundColorForControlState.put(ControlState.NORMAL, color(1, 0, 0, 0));
    backgroundColorForControlState.put(ControlState.HIGHLIGHTED, color(1, 0, 0, 0));
    backgroundColorForControlState.put(ControlState.SELECTED, color(1, 0, 0, 0));
    textPadding = 0;
    updateSize();
  }
}
