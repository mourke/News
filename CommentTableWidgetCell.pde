public class CommentTableWidgetCell extends TableWidgetCell {
  protected Label commentLabel;
  
  CommentTableWidgetCell(Rect frame, TableWidgetCellDelegate delegate) {
    super(frame, delegate);
    
    titleLabel.setFont(textFont);
    subtitleLabel.setFont(captionFont);
    
    titleLabel.frame.origin.x = frame.origin.x + 20;
    titleLabel.frame.origin.y = frame.origin.y + 10;
    subtitleLabel.frame.origin.x = titleLabel.frame.origin.x;
    subtitleLabel.frame.origin.y = titleLabel.frame.origin.y + titleLabel.frame.size.height + 8;
    subtitleLabel.setTextColor(color(0, 0, 0, 102));
    
    commentLabel = new Label("Comment", new Point(subtitleLabel.frame.origin.x, subtitleLabel.frame.origin.y + subtitleLabel.frame.size.height + 20));
    commentLabel.setFont(captionFont);
    commentLabel.setMaxLines(10);
    commentLabel.setMaxWidth(titleLabel.maxWidth());
    addChildWidget(commentLabel);
    
    cornerRadius = 2;
    backgroundColor = color(239, 239, 244);
    selectedBackgroundColor = backgroundColor;
  }
}
