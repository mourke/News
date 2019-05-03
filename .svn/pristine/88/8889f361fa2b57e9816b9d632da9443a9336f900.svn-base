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
  
  for(int i=0; i<entries.size(); i++) {
    print(entries.get(i));
  }
}

void draw() {

}
