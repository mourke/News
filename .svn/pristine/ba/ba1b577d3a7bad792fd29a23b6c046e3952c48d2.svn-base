ArrayList<Comment> comments;
ArrayList<Story> stories;
ArrayList<Comment> matchingComments;
ArrayList<Story> matchingStories;
ArrayList<Textbox> textboxes;

public PFont titleFont;
public PFont subtitleFont;
public PFont textFont;
public PFont captionFont;

//---Claire---
Textbox userpageTextbox;

PImage search;
PFont widgetFont;
PFont usernameFont;
PFont userpageContentHeader;
PFont widgetFontLarger;
PFont quoteFont;
PFont textboxFont;

UserPage userpage;
boolean userpageSearchFailed;
float averageStoryScore;
float maxStoryScore;
PImage gold;
PImage silver;
PImage bronze;
PImage rightArrow;
PImage back;
//----

Window currentWindow;
MainWindow mainWindow;
Graph graph1;
timeFilter filter1;

void settings() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}

void setup() {
  comments = new ArrayList<Comment>();
  stories = new ArrayList<Story>();
  textboxes = new ArrayList<Textbox>();

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

  mainWindow = new MainWindow();
  mainWindow.setDataSource(stories);
  currentWindow = mainWindow;
  filter1 = new timeFilter(stories); 

  graph1 = new Graph(filter1.getFirstDayOfWeek(filter1.startTime(2007, 11)), stories);

  //---Claire---
  search = loadImage("search.png");
  usernameFont = loadFont("Ebrima-Bold-64.vlw");
  userpageContentHeader = loadFont("Ebrima-Bold-32.vlw");
  widgetFont = loadFont("LeelawadeeUI-Semilight-24.vlw");
  widgetFontLarger = loadFont("LeelawadeeUI-Semilight-48.vlw");
  quoteFont = loadFont("SansSerif.italic-32.vlw");
  textboxFont = loadFont("SegoeUI-20.vlw");
  textFont(widgetFont);

  userpageTextbox = new Textbox(SCREEN_WIDTH - 500, 20, TEXTBOX_USERPAGE);
  textboxes.add(userpageTextbox);
  userpageTextbox.setPlaceholderText("Username ");
  //query = QUERY_USERPAGE;
  userpageSearchFailed = false;

  gold = loadImage("gold.png");
  silver = loadImage("silver.png");
  bronze = loadImage("bronze.png");
  rightArrow = loadImage("rightarrow.png");
  back = loadImage("back.png");
  //---
}

void draw() {
  currentWindow.draw();
  switch(mainWindow.getIndexState()) {
  case 0:


    break;
  case 1:


    break;
  case 2:


    break;
  case 3:
    graph1.draw();


    break;
  case 4:
    for (Textbox t : textboxes) {
      t.draw();
    }

    //back.draw();

    if (userpage != null) {
      userpage.draw();
    } else {
      fill(227);
      stroke(0);
      rect(USERPAGE_FRAME_X, USERPAGE_FRAME_Y, SCREEN_WIDTH, SCREEN_HEIGHT - USERPAGE_FRAME_Y);
    }
    if (userpageSearchFailed) {
      fill(0);
      textFont(widgetFont);
      text("No result found.", USERPAGE_FRAME_X + 50, USERPAGE_FRAME_Y+50+64);
    }
    //back
    image(back, SCREEN_WIDTH-74, 20);
    break;
  }
}

void mousePressed() {
  currentWindow.mousePressed();
  if (mainWindow.getIndexState() == 3) {
    int[][] chartArray = graph1.getChartArray();
    int mousexCheck = mouseX;
    int mouseyCheck = mouseY;

  outer: 
    for (int index=0; index<chartArray.length; index++) {

      int tempBarX = 0;
      int tempWidth = 0;
      int currentYpos = 0;
      int currentYHeight = 0;
      for (int jIndex=0; jIndex <chartArray[index].length; jIndex ++) {
        switch(jIndex) {
        case 0:
          tempBarX = chartArray[index][jIndex];

          break;    
        case 1:
          tempWidth = chartArray[index][jIndex];

          break;

        case 2:
          currentYpos = chartArray[index][jIndex];

          break;

        case 3:
          currentYHeight = chartArray[index][jIndex];

          break;
        }
      }
      if (mouseX >= tempBarX && mouseX <= tempBarX+tempWidth && mouseY >= currentYpos && mouseY <= currentYpos+currentYHeight) {
        println("got bar " +index);
        graph1.getChartState(true, index);
        break outer;
      }
    }
    //---Claire---
  } else if (mainWindow.getIndexState() == 4) {
    
    //back
    if (mouseX >= SCREEN_WIDTH-74 && mouseX < SCREEN_WIDTH && mouseY >= 20 && mouseY <= 20+48) {
      mainWindow.selectedSegmentIndexChanged(0);
    }
    
    //textboxes
    for (Textbox textbox : textboxes) {
      if (textbox.withinBounds(mouseX, mouseY)) {
        textbox.click();
      } else {
        textbox.deselect();
      }
    }
    
    //userpage
    if (userpage != null) {
      if (!userpage.itemActive()) {
        println("Item inactive");
        if (userpage.contentPaneActive()) {  // runs after second click in content pane
          userpage.setActiveItem(mouseY);
        }

        if (userpage.contentPaneClicked(mouseX, mouseY)) {
          userpage.setContentPaneActive();
        } else {
          userpage.setContentPaneInactive();
        }
      } else {
        println("item active");
        //if (userpage.linkClicked()) {
        //  userpage.openLink();
        //}
        userpage.toggleActiveItem();
      }
    }
  }
  
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

//---Claire---
public void keyPressed() {
  //textboxes
  for (Textbox textbox : textboxes) {
    if (textbox.isSelected()) {
      if (key == BACKSPACE) {
        textbox.removeChar();
      } else if (key == ENTER) {
        textbox.submitQuery();
      } else {
        textbox.appendCharacter(key);
      }
    }
  }

  //userpage
  if (userpage != null) {
    if (userpage.contentPaneActive()) {
      if (keyCode == RIGHT) {
        userpage.advanceContent();
      } else if (keyCode == LEFT) {
        userpage.retreatContent();
      }
    }
  }
}
//-----

//---Claire---
public ArrayList<Comment> getCommentsByUsername(ArrayList<Comment> comments, String username) {
  ArrayList<Comment> commentsByUsername = new ArrayList<Comment>();

  for (Comment c : comments) {
    try {
      if (c.author().equalsIgnoreCase(username)) {
        commentsByUsername.add(c);
      }
    } 
    catch (Exception e) {
      //println("Error matching username: " + c + ": " + e);
    }
  }

  return commentsByUsername;
}

public ArrayList<Story> getStoriesByUsername(ArrayList<Story> stories, String username) {
  ArrayList<Story> storiesByUsername = new ArrayList<Story>();

  for (Story s : stories) {
    try {
      if (s.author().equalsIgnoreCase(username)) {
        storiesByUsername.add(s);
      }
    } 
    catch (Exception e) {
      //println("Error matching username: " + s + ": " + e);
    }
  }

  return storiesByUsername;
}

public Item getParent(int id) {
  for (Story s : stories) {
    if (s.id().equals(id)) {
      return s;
    }
  }
  for (Comment c : comments) {
    if (c.id().equals(id)) {
      return c;
    }
  }
  return null;
}

public void setUserpageSubject(String username) {
  try {
    userpage = new UserPage(new User(username));
    userpageSearchFailed = false;
  } 
  catch (Exception e) { // username has no results
    userpage = null;
    userpageSearchFailed = true;
  }
}

//public void setUsername(String s) {
//  matchingComments = getCommentsByUsername(comments, s);
//  matchingStories = getStoriesByUsername(stories, s);
//  //query = QUERY_COMMENT_BY_USERNAME;
//  for (RadioButton r : usernameSearchOptions) {
//    if (r.event() == QUERY_COMMENT_BY_USERNAME) {
//      r.select();
//    }
//  }
//  // userpage = new UserPage(new User(s));
//}
//----
