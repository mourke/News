public class RadioButton extends Checkbox {
  
  public RadioButton(Rect frame, ButtonDelegate delegate) {
    super(frame, delegate);
    this.checkedImage = null;
    this.image = null;
    
  }
  
  public void draw() {
    this.cornerRadius = frame.size.height/2;
    
    super.draw();
    
    if (checked) {
      fill(255);
      float size = frame.size.width/2.5;
      ellipse(frame.origin.x + (frame.size.height - size)/2, frame.origin.y + (frame.size.height - size)/2, size, size);
    }
  }
}
