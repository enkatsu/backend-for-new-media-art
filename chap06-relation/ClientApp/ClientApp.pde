import http.requests.*;

String API_URL = "http://localhost:3000/lines";
ArrayList<Line> lines;
Line drawingLine = null;

void setup() {
  size(640, 480);
  lines = new ArrayList<Line>();
  loadLines();
}

void draw() {
  background(0);

  if (drawingLine != null) {
    drawingLine.draw();
  }

  for (Line line : lines) {
    line.draw();
  }
}

void mousePressed() {
  drawingLine = new Line();
}

void mouseDragged() {
  if (drawingLine != null) {
    if (drawingLine.points.size() == 0) {
      drawingLine.points.add(new PVector(mouseX, mouseY));
    } else {
      PVector last = drawingLine.points
        .get(drawingLine.points.size() - 1);
      if (dist(mouseX, mouseY, last.x, last.y) > 10) {
        drawingLine.points.add(new PVector(mouseX, mouseY));
      }
    }
  }
}

void mouseReleased() {
  if (drawingLine != null) {
    JSONObject line = new JSONObject();
    JSONArray points = new JSONArray();
    for (int i = 0; i < drawingLine.points.size(); i++) {
      PVector p = drawingLine.points.get(i);
      JSONObject point = new JSONObject();
      point.setFloat("x", p.x);
      point.setFloat("y", p.y);
      points.setJSONObject(i, point);
    }
    line.setJSONArray("points", points);
    PostRequest post = new PostRequest(API_URL);
    post.addHeader("Content-Type", "application/json");
    post.addData(line.toString());
    post.send();
    drawingLine = null;
    lines.clear();
    loadLines();
  }
}

void loadLines() {
  GetRequest get = new GetRequest(API_URL);
  get.send();
  JSONObject result = parseJSONObject(get.getContent());
  JSONArray ls = result.getJSONArray("lines");
  for (int i = 0; i <  ls.size(); i++) {
    ArrayList<PVector> points = new ArrayList<PVector>();
    JSONObject l = ls.getJSONObject(i);
    JSONArray ps = l.getJSONArray("points");
    for (int j = 0; j < ps.size(); j++) {
      JSONObject p = ps.getJSONObject(j);
      points.add(new PVector(p.getFloat("x"), p.getFloat("y")));
    }
    lines.add(new Line(l.getInt("id"), points));
  }
}
