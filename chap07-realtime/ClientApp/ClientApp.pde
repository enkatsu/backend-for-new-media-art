import websockets.*;
import org.eclipse.jetty.websocket.api.Session;

WebsocketClient client;
String WS_URI = "ws://localhost:5001";
ArrayList<Line> lines;
HashMap<String, Line> drawingLines;

void setup() {
  size(640, 480);
  client = new WebsocketClient(this, WS_URI);
  lines = new ArrayList<Line>();
  drawingLines = new HashMap<String, Line>();
}

void draw() {
  background(0);

  for (Line line : drawingLines.values()) {
    line.draw();
  }

  for (Line line : lines) {
    line.draw();
  }
}

void mousePressed() {
  JSONObject event = new JSONObject();
  event.setString("type", "start");
  client.sendMessage(event.toString());
}

void mouseDragged() {
  JSONObject event = new JSONObject();
  event.setString("type", "add");
  JSONObject point = new JSONObject();
  point.setFloat("x", mouseX);
  point.setFloat("y", mouseY);
  event.setJSONObject("point", point);
  client.sendMessage(event.toString());
}

void mouseReleased() {
  JSONObject event = new JSONObject();
  event.setString("type", "end");
  client.sendMessage(event.toString());
}

void webSocketEvent(String msg) {
  JSONObject event = parseJSONObject(msg);
  println(event);

  String type = event.getString("type");
  String painterId = event.getString("painter_id");

  switch (type) {
  case "start":
    {
      drawingLines.put(painterId, new Line());
      break;
    }
  case "add":
    {
      Line line = drawingLines.get(painterId);
      JSONObject point = event.getJSONObject("point");
      float x = point.getFloat("x");
      float y = point.getFloat("y");
      line.points.add(new PVector(x, y));
      break;
    }
  case "end":
    {
      Line line = drawingLines.remove(painterId);
      lines.add(line);
      break;
    }
  default:
    break;
  }
}
