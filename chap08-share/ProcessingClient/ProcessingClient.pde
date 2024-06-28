import websockets.*;
import org.eclipse.jetty.websocket.api.Session;

HashMap<String, PVector> lightPositions;
WebsocketClient client;
String WS_URI = "ws://localhost:5001";


void setup() {
  size(640, 480);
  client = new WebsocketClient(this, WS_URI);
  lightPositions = new HashMap<String, PVector>();
}

void draw() {
  background(0);
  
  noStroke();
  fill(250, 250, 200);
  for (PVector lightPosition: lightPositions.values()) {
    ellipse(lightPosition.x, lightPosition.y, 50, 50);
  }

  noStroke();
  fill(0);
  rect(100, 100, 50, 50);
}

void webSocketEvent(String msg) {
  JSONObject light = parseJSONObject(msg);
  String type = light.getString("type");
  String uuid = light.getString("uuid");
  switch (type) {
  case "lightup":
    {
      float x = light.getFloat("x");
      float y = light.getFloat("y");
      lightPositions.put(uuid, new PVector(x, y));
      break;
    }
  case "move":
    {
      float x = light.getFloat("x");
      float y = light.getFloat("y");
      PVector lightPosition = lightPositions.get(uuid);
      lightPosition.set(x, y);
      break;
    }
  case "lightoff":
    {
      lightPositions.remove(uuid);
      break;
    }
  default:
    {
      break;
    }
  }
}
