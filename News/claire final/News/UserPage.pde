class UserPage {

  private User subject;
  private int x;
  private int y;
  private int frameWidth;
  private int frameHeight;
  private String mostRecentActivity;
  private boolean contentPaneActive;
  private ArrayList<Item> content;
  private int contentIndex;
  private Item activeItem;  // story/comment user has selected for viewing


  public UserPage(User subject) {
    this.subject = subject;

    x = USERPAGE_FRAME_X;
    y = USERPAGE_FRAME_Y;
    frameWidth = SCREEN_WIDTH-x;
    frameHeight = SCREEN_HEIGHT-y;

    SimpleDateFormat format = new SimpleDateFormat("EEE, d MMM yyyy HH:mm:ss");
    mostRecentActivity = format.format(subject.lastActivity());

    content = new ArrayList<Item>();
    content.addAll(subject.stories());
    content.addAll(subject.comments());

    contentIndex = 0;
  }

  public void draw() {
    tint(255, 255);

    //frame
    stroke(0);
    fill(227);
    rect(x, y, frameWidth, frameHeight);

    //username
    fill(0);
    //textSize(64);
    textFont(usernameFont);
    text(subject.username(), x+SCREEN_WIDTH/10, y+USERNAME_TEXT_SIZE);

    //profile pic
    fill(255);
    noStroke();
    //rect(x+150, y+2*50+USERNAME_TEXT_SIZE, 256, 256);
    image(subject.pic(), x+SCREEN_WIDTH/10, y+1.5*USERNAME_TEXT_SIZE);

    // content
    fill(0);
    textFont(widgetFont);
    text("Top Score:    "+subject.topScore(), frameWidth/2.5, 1.3*y+50+USERNAME_TEXT_SIZE);
    text("Total Contributions:    "+subject.numContributions(), frameWidth/2.5, 1.3*y+50+USERNAME_TEXT_SIZE+2*WIDGET_TEXT_SIZE);
    text("Last Activity:    "+mostRecentActivity, frameWidth/2.5, 1.3*y+50+USERNAME_TEXT_SIZE+4*WIDGET_TEXT_SIZE);
    
    //Content instructions
    fill(140);
    text("Click to view an item in detail, left and right arrow keys to navigate: ", 32, USERPAGE_CONTENT_DIVIDER_Y - 16);

    //divider
    stroke(198);
    line(0, USERPAGE_CONTENT_DIVIDER_Y, SCREEN_WIDTH, USERPAGE_CONTENT_DIVIDER_Y);
    if (contentPaneActive) {
      stroke(171, 213, 245);
      fill(237, 244, 250);
    } else {
      stroke(198);
      fill(255);
    }
    rect(0, USERPAGE_CONTENT_DIVIDER_Y+1, SCREEN_WIDTH, SCREEN_HEIGHT - USERPAGE_CONTENT_DIVIDER_Y);

    //content (3 printed per page);
    if (content.size()!=0) {
      textFont(widgetFontLarger);
      fill(0);
      try {
        for (int i=0; i<3; i++) {
          textFont(userpageContentHeader);
          Item item = content.get(contentIndex+i);
          text((item.type() == Type.STORY)?"Story: ":"Comment: ", x+50, USERPAGE_CONTENT_DIVIDER_Y + 20 * 3.5*(i+1));
          textFont(widgetFont);
          if (item.type() == Type.STORY) {
            Story itemStory = (Story)item;
            String title = itemStory.title().replaceAll("\\<[^>]*>", "");
            title = title.replace("\n", " ");
            if (title.length() > USERPAGE_ITEM_MAX_CHARS-10) {
              title = title.substring(0, USERPAGE_ITEM_MAX_CHARS-10)+"...";
            }
            text(title, x + textWidth("Story: ") + 150, USERPAGE_CONTENT_DIVIDER_Y + 20 * 3.5*(i+1));
          } else {  //comment
            Comment itemComment = (Comment)item;
            String text = itemComment.text().replaceAll("\\<[^>]*>", "");
            text = text.replace("\n", " ");
            if (text.length() > USERPAGE_ITEM_MAX_CHARS-10) {
              text = text.substring(0, USERPAGE_ITEM_MAX_CHARS-10)+"...";
            }
            text(text, x + textWidth("Comment: ") + 150, USERPAGE_CONTENT_DIVIDER_Y + 20 * 3.5*(i+1));
          }

          if (contentIndex + 3 < content.size()) {
            image(rightArrow, SCREEN_WIDTH - SCREEN_WIDTH/10, SCREEN_HEIGHT - SCREEN_HEIGHT/16 -32);
          }

          //text(content.get(contentIndex).toString(), x+50, USERPAGE_CONTENT_DIVIDER_Y + 30 * 3);
          //text(content.get(contentIndex+1).toString(), x+50, USERPAGE_CONTENT_DIVIDER_Y + 30 * 6);
          //text(content.get(contentIndex+2).toString(), x+50, USERPAGE_CONTENT_DIVIDER_Y + 30 * 9);
        }
      } 
      catch (Exception e) {  // null pointer if not a multiple of 3
      }
    }

    if (activeItem != null) {
      fill(0, 160);
      tint(255, 127); // shade out rest of screen
      rect(-5, 0, SCREEN_WIDTH+5, SCREEN_HEIGHT+5);

      fill(255);
      rect(SCREEN_WIDTH/10, SCREEN_HEIGHT/4, 8*SCREEN_WIDTH/10, 5*SCREEN_HEIGHT/8);
      drawActiveItem();
    }
  }

  public void setContentPaneActive() {
    contentPaneActive = true;
  }

  public void setContentPaneInactive() {
    contentPaneActive = false;
  }

  public boolean contentPaneActive() {
    return contentPaneActive;
  }

  public boolean contentPaneClicked(int mX, int mY) {
    return (mX>=0&&mX<=SCREEN_WIDTH&&mY>=USERPAGE_CONTENT_DIVIDER_Y&&mY<SCREEN_HEIGHT);
  }

  public void advanceContent() {
    println("Content index: " + contentIndex + ", content size: " + content.size());
    if (contentIndex+3 < content.size()) {  //dont allow to show a set of 3 empty queries (past size)
      contentIndex+=3;
    }
  }

  public void retreatContent() {
    if (contentIndex-3 >= 0) {  //dont allow to go too far back
      contentIndex-=3;
    }
  }

  public void setActiveItem(int mY) {
    try {
      if (mY >= USERPAGE_CONTENT_DIVIDER_Y && mY <= USERPAGE_CONTENT_DIVIDER_Y + USERPAGE_ITEM_HEIGHT) {
        //print("Item 1");
        activeItem = content.get(contentIndex);
      } else if (mY >= USERPAGE_CONTENT_DIVIDER_Y + USERPAGE_ITEM_HEIGHT && mY <= USERPAGE_CONTENT_DIVIDER_Y + USERPAGE_ITEM_HEIGHT*2) {
        //print("Item 2");
        activeItem = content.get(contentIndex+1);
      } else if (mY >= USERPAGE_CONTENT_DIVIDER_Y + USERPAGE_ITEM_HEIGHT*2 && mY <= SCREEN_HEIGHT) {
        activeItem = content.get(contentIndex+2); 
        //print("Item 3");
      }
    } 
    catch (NullPointerException e) {
      //item doesnt exist at that location; do nothing
    }
  }

  public boolean itemActive() {
    return activeItem != null;
  }

  public void toggleActiveItem() {
    activeItem = null;
  }

  public void drawActiveItem() {
    //rect(SCREEN_WIDTH/4, SCREEN_HEIGHT/4, SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    fill(104, 156, 206);
    textFont(usernameFont);
    Type itemType = activeItem.type();
    if (itemType == Type.STORY) {
      Story activeStory = (Story)activeItem;
      text("Story: ", SCREEN_WIDTH/10+50, SCREEN_HEIGHT/4 + 64);
      String title = activeStory.title();
      if (title.length() >= 80) {  // shorten titles that are too long; will be at most 3 lines
        title = title.substring(0, 80) + "...";
      }
      //println(title);
      //title
      textFont(userpageContentHeader);
      int urlOffset = (int)textWidth(title)/(4*(SCREEN_WIDTH/5)-50-64); // how many textHeights we need to move URL down to prevent overlapping
      print(urlOffset);
      fill(0);
      text("\""+title+"\"", SCREEN_WIDTH/10+50, SCREEN_HEIGHT/4 + 1.5*64, (4*SCREEN_WIDTH/5)-50-64, 5*SCREEN_HEIGHT/8);
      fill(100);
      String url = activeStory.url().toString();
      textFont(widgetFont);

      //url
      String urlText = url.substring(9, url.length()-1);
      if (urlText.equals("empt")) {
        urlText = "<No URL>";
      }
      if (urlText.length() > 200) {
        urlText = urlText.substring(0, 200)+"...";  // protect against very long urls
      }
      text(urlText, SCREEN_WIDTH/10+50, SCREEN_HEIGHT/4 + 32*(5+urlOffset), (4*SCREEN_WIDTH/5)-50-64, 5*SCREEN_HEIGHT/8);

      //stats
      Date date = activeItem.releaseDate();
      SimpleDateFormat format = new SimpleDateFormat("EEE, d MMM yyyy HH:mm:ss");
      String itemDate = format.format(date);
      fill(143, 192, 240);
      text("Date: "+itemDate, SCREEN_WIDTH/10+50, 9*SCREEN_HEIGHT/10-64);

      int itemScore = ((Story)activeItem).score();
      String scoreString = "Score: "+itemScore;
      text(scoreString, 9*SCREEN_WIDTH/10 - textWidth(scoreString)-50, 9*SCREEN_HEIGHT/10-64);
      
    } else if (itemType == Type.COMMENT) {
      
      //title
      text("Comment: ", SCREEN_WIDTH/10+50, SCREEN_HEIGHT/4 + 64);
      // print what they're responding to
      int parentId = ((Comment)activeItem).parentId();
      Item parent = getParent(parentId);
      textFont(widgetFont);
      if (parent.type() == Type.STORY) {
        text("Parent Story: ", SCREEN_WIDTH/10+50, SCREEN_HEIGHT/4 + 2*64);
        fill(180);
        //textFont(quoteFont);
        String parentText = ((Story)parent).title();
        if (parentText.length() >= USERPAGE_PARENT_STORY_MAX_CHARS) {
          parentText = parentText.substring(0, USERPAGE_PARENT_STORY_MAX_CHARS-5) + "...";
        }
        text("\""+parentText+"\"", SCREEN_WIDTH/10+50+textWidth("Parent Story: "), SCREEN_HEIGHT/4 + 2*64);
      } else if (parent.type() == Type.COMMENT) {
        text("Parent Comment: ", SCREEN_WIDTH/10+50, SCREEN_HEIGHT/4 + 2*64);
        fill(180);
        String parentText = ((Comment)parent).text();
        if (parentText.length() >= USERPAGE_PARENT_COMMENT_MAX_CHARS) {
          parentText = parentText.substring(0, USERPAGE_PARENT_COMMENT_MAX_CHARS-5) + "...";
        }
        text("\""+ parentText+"\"", SCREEN_WIDTH/10+50+textWidth("Parent Comment: "), SCREEN_HEIGHT/4 + 2*64);
      }

      //print comment text
      fill(0);
      String commentText = ((Comment)activeItem).text();
      commentText = commentText.replaceAll("\\<[^>]*>", "");
      if (commentText.length() >= 400) {
        commentText = commentText.substring(0,397) + "...";
      }
      text(commentText, SCREEN_WIDTH/10+50, SCREEN_HEIGHT/4 + 2.5*64, (4*SCREEN_WIDTH/5)-50-64, 3*SCREEN_HEIGHT/4);
      
      //Print comment date
      Date date = activeItem.releaseDate();
      SimpleDateFormat format = new SimpleDateFormat("EEE, d MMM yyyy HH:mm:ss");
      String itemDate = format.format(date);
      fill(143, 192, 240);
      text("Date: "+itemDate, SCREEN_WIDTH/10+50, 9*SCREEN_HEIGHT/10-64);
      
    }
  }

  //void openLink() {
  //  link(((Story)activeItem).URL);
  //}

  //boolean linkClicked(int mX, int mY) {
  //   //SCREEN_WIDTH/4+50, SCREEN_HEIGHT/4 + 100 + 64, 3*SCREEN_WIDTH/4, 3*SCREEN_HEIGHT/4
  //  if (mX >= SCREEN_WIDTH/4+50 && mX <= SCREEN_WIDTH/4+50+64
  //}
}