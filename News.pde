final int SCREEN_HEIGHT = 750;
final int SCREEN_WIDTH = 1000;

public PFont titleFont;
public PFont subtitleFont;
public PFont textFont;
public PFont captionFont;

Graph graph1;
timeFilter filter1;

MainWindow currentWindow;

void settings() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}

void setup() {
  ArrayList<Comment> comments = new ArrayList<Comment>();
  ArrayList<Story> stories = new ArrayList<Story>();

  JSONArray array = loadJSONArray("news.json");

  for (int i = 0; i < array.size(); ++i) {
    JSONObject object = array.getJSONObject(i);
    try {
      if (object.getString("type").equals("story")) {
        stories.add(new Story(object));
      } else {
        comments.add(new Comment(object));
      }
    } 
    catch (Exception e) {
      println(e);
    }
  }

  titleFont = loadFont("titleFont.vlw");
  subtitleFont = loadFont("subtitleFont.vlw");
  textFont = loadFont("textFont.vlw");
  captionFont = loadFont("captionFont.vlw");

  MainWindow mainWindow = new MainWindow(stories, comments);
  currentWindow = mainWindow;

  //filter1 = new timeFilter(stories); 
  //graph1 = new Graph(filter1.startTime(2006,40), stories);
}

void draw() {
  currentWindow.draw();

  // graph1.draw();
}

void mousePressed() {
  currentWindow.mousePressed();
}

void mouseMoved() {
  currentWindow.mouseMoved();
}

void mouseReleased() {
  currentWindow.mouseReleased();
}

void mouseDragged() {
  currentWindow.mouseDragged();
}

void mouseWheel(MouseEvent event) {
  currentWindow.mouseWheel(event);
}

void keyPressed() {
  currentWindow.keyPressed();
}
