//Prints first 10 comments in entries

JSONArray entries;

void setup() {
  String[] temps = loadStrings("data_10000.txt");
  entries = new JSONArray();
  
  for (int i=0; i<temps.length; i++) {
    String temp = temps[i];
    JSONObject newObject = parseJSONObject(temp);
    if (newObject != null) {
      entries.append(newObject);
    }
  }
  
  int i=0;
  int count = 0;
  while (count<10) {
    if (entries.getJSONObject(i).getString("type").equals("comment")) {
          print(entries.get(i)+"\n");
          count++;
    }
    i++;
  }
}

void draw() {

}
