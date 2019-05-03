public class RadioButton extends Checkbox {
  
  public RadioButton(Rect frame, ButtonDelegate delegate) {
    super(frame, delegate);
    this.checkedImage = null;
    this.image = null;
    
  }
  
  public void draw() {
    this.cornerRadius = frame.height/2;
    
    super.draw();
    
    if (checked) {
      fill(255);
      float size = frame.width/2.5;
      ellipse(frame.x + (frame.height - size)/2, frame.y + (frame.height - size)/2, size, size);
    }
  }
}
